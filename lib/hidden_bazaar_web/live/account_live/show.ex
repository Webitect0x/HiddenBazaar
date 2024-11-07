defmodule HiddenBazaarWeb.AccountLive.Show do
  use HiddenBazaarWeb, :live_view

  def render(assigns) do
    ~H"""
    <main>
      <h1><%= @current_user.username %></h1>
    </main>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket, layout: {HiddenBazaarWeb.Layouts, :account}}
  end
end
