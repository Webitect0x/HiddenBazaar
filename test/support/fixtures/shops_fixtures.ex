defmodule HiddenBazaar.ShopsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HiddenBazaar.Shops` context.
  """

  @doc """
  Generate a shop.
  """
  def shop_fixture(attrs \\ %{}) do
    {:ok, shop} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        shop_avatar: "some shop_avatar",
        shop_banner: "some shop_banner"
      })
      |> HiddenBazaar.Shops.create_shop()

    shop
  end
end
