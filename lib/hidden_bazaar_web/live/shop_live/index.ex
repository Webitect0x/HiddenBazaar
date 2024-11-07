defmodule HiddenBazaarWeb.ShopLive.Index do
  use HiddenBazaarWeb, :live_view

  alias HiddenBazaar.Shops
  alias HiddenBazaar.Shops.Shop

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :shops, Shops.list_shops()), layout: {HiddenBazaarWeb.Layouts, :account}}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Shop")
    |> assign(:shop, Shops.get_shop!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Shop")
    |> assign(:shop, %Shop{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Shops")
    |> assign(:shop, nil)
  end

  @impl true
  def handle_info({HiddenBazaarWeb.ShopLive.FormComponent, {:saved, shop}}, socket) do
    {:noreply, stream_insert(socket, :shops, shop)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    shop = Shops.get_shop!(id)
    {:ok, _} = Shops.delete_shop(shop)

    {:noreply, stream_delete(socket, :shops, shop)}
  end
end
