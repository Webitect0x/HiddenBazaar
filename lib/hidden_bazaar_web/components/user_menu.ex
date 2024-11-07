defmodule HiddenBazaarWeb.Components.UserMenu do
  use Phoenix.Component

  def user_menu(assigns) do
    ~H"""
    <ul
      class="absolute z-[10] top-[2rem] p-3 w-[7rem] "
      id="user-menu"
      hidden
      phx-click-away={assigns.toggle_menu}
    >
      <li>
        <.link
          href="/account"
          class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
        >
          My Account
        </.link>
      </li>
      <li>
        <.link
          href="/users/settings"
          class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
        >
          Settings
        </.link>
      </li>
      <li>
        <.link
          href="/users/log_out"
          method="delete"
          class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
        >
          Log out
        </.link>
      </li>
    </ul>
    """
  end
end
