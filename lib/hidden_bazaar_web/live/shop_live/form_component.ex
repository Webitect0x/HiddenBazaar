defmodule HiddenBazaarWeb.ShopLive.FormComponent do
  use HiddenBazaarWeb, :live_component

  alias HiddenBazaar.Shops
  alias HiddenBazaar.Accounts.User

  alias Phoenix.VerifiedRoutes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage shop records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="shop-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />

        <.label for="shop_avatar">Shop avatar</.label>
        <.live_file_input upload={@uploads.shop_avatar} />
        <.label for="shop_banner">Shop banner</.label>
        <.live_file_input upload={@uploads.shop_banner} />

        <%= for entry <- @uploads.shop_avatar.entries do %>
          <.live_img_preview entry={entry} class="w-32 h-32" />
        <% end %>

        <%= for entry <- @uploads.shop_banner.entries do %>
          <.live_img_preview entry={entry} />
        <% end %>

        <:actions>
          <.button phx-disable-with="Saving...">Save Shop</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{shop: shop} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> allow_upload(:shop_avatar, accept: ~w(.jpg .jpeg .png), max_entries: 1)
     |> allow_upload(:shop_banner, accept: ~w(.jpg .jpeg .png), max_entries: 1)
     |> assign_new(:form, fn ->
       to_form(Shops.change_shop(shop))
     end)}
  end

  @impl true
  def handle_event("validate", %{"shop" => shop_params}, socket) do
    changeset = Shops.change_shop(socket.assigns.shop, shop_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"shop" => shop_params}, socket) do
    save_shop(socket, socket.assigns.action, shop_params)
  end

  defp save_shop(socket, :edit, shop_params) do
    case Shops.update_shop(socket.assigns.shop, shop_params) do
      {:ok, shop} ->
        notify_parent({:saved, shop})

        {:noreply,
         socket
         |> put_flash(:info, "Shop updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_shop(socket, :new, shop_params) do
    with %User{} = user <- socket.assigns.current_user do
      shop_avatar = media_upload(socket, :shop_avatar)
      shop_banner = media_upload(socket, :shop_banner)

      updated_shop_params = Map.put(shop_params, "shop_avatar", Enum.at(shop_avatar, 0))
      updated_shop_params = Map.put(updated_shop_params, "shop_banner", Enum.at(shop_banner, 0))

      case Shops.create_shop(updated_shop_params, user) do
        {:ok, shop} ->
          notify_parent({:saved, shop})

          {:noreply,
           socket
           |> put_flash(:info, "Shop created successfully")
           |> push_patch(to: socket.assigns.patch)}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, form: to_form(changeset))}
      end
    else
      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "You must be logged in to create a shop")
         |> push_patch(to: ~p"/shop")}
    end
  end

  def media_upload(socket, name) do
    consume_uploaded_entries(socket, name, fn meta, entry ->
      dest =
        Path.join(["priv", "static", "uploads", "#{entry.uuid}-#{entry.client_name}"])

      File.cp!(meta.path, dest)

      url_path = VerifiedRoutes.static_path(socket, "/uploads/#{Path.basename(dest)}")

      {:ok, url_path}
    end)
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
