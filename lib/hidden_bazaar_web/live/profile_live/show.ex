defmodule HiddenBazaarWeb.ProfileLive.Show do
  use HiddenBazaarWeb, :live_view

  alias HiddenBazaar.Accounts

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"username" => username}, _, socket) do
    {:noreply, assign(socket, :profile, Accounts.get_user_by_username(username))}
  end
end
