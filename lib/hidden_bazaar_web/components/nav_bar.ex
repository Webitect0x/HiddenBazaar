defmodule HiddenBazaarWeb.Components.NavBar do
  use HiddenBazaarWeb, :live_component

  import HiddenBazaarWeb.Components.UserMenu
  import HiddenBazaarWeb.Components.ToggleMenu

  def render(assigns) do
    ~H"""
    <header class="px-4 sm:px-6 lg:px-8">
      <nav class="flex items-center justify-between p-4">
        <h1>HiddenBazaar</h1>
        <ul class="relative z-10 flex items-center gap-4 px-4 sm:px-6 lg:px-8 justify-end">
          <%= if @current_user do %>
            <div class="flex items-center gap-4 cursor-pointer" phx-click={toggle_menu()}>
              <%= @current_user.username %>
            </div>
            <.user_menu current_user={@current_user} toggle_menu={toggle_menu()} />
          <% else %>
            <li>
              <.link
                href={~p"/users/register"}
                class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Register
              </.link>
            </li>
            <li>
              <.link
                href={~p"/users/log_in"}
                class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Log in
              </.link>
            </li>
          <% end %>
        </ul>
      </nav>
    </header>
    """
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end
end
