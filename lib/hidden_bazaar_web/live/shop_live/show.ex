defmodule HiddenBazaarWeb.ShopLive.Show do
  use HiddenBazaarWeb, :live_view

  alias HiddenBazaar.Shops

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:shop, Shops.get_shop!(id))}
  end

  defp page_title(:show), do: "Show Shop"
  defp page_title(:edit), do: "Edit Shop"
end
