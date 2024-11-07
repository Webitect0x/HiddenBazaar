defmodule HiddenBazaar.ShopsTest do
  use HiddenBazaar.DataCase

  alias HiddenBazaar.Shops

  describe "shops" do
    alias HiddenBazaar.Shops.Shop

    import HiddenBazaar.ShopsFixtures

    @invalid_attrs %{name: nil, description: nil, shop_avatar: nil, shop_banner: nil}

    test "list_shops/0 returns all shops" do
      shop = shop_fixture()
      assert Shops.list_shops() == [shop]
    end

    test "get_shop!/1 returns the shop with given id" do
      shop = shop_fixture()
      assert Shops.get_shop!(shop.id) == shop
    end

    test "create_shop/1 with valid data creates a shop" do
      valid_attrs = %{
        name: "some name",
        description: "some description",
        shop_avatar: "some shop_avatar",
        shop_banner: "some shop_banner"
      }

      assert {:ok, %Shop{} = shop} = Shops.create_shop(valid_attrs)
      assert shop.name == "some name"
      assert shop.description == "some description"
      assert shop.shop_avatar == "some shop_avatar"
      assert shop.shop_banner == "some shop_banner"
    end

    test "create_shop/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shops.create_shop(@invalid_attrs)
    end

    test "update_shop/2 with valid data updates the shop" do
      shop = shop_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        shop_avatar: "some updated shop_avatar",
        shop_banner: "some updated shop_banner"
      }

      assert {:ok, %Shop{} = shop} = Shops.update_shop(shop, update_attrs)
      assert shop.name == "some updated name"
      assert shop.description == "some updated description"
      assert shop.shop_avatar == "some updated shop_avatar"
      assert shop.shop_banner == "some updated shop_banner"
    end

    test "update_shop/2 with invalid data returns error changeset" do
      shop = shop_fixture()
      assert {:error, %Ecto.Changeset{}} = Shops.update_shop(shop, @invalid_attrs)
      assert shop == Shops.get_shop!(shop.id)
    end

    test "delete_shop/1 deletes the shop" do
      shop = shop_fixture()
      assert {:ok, %Shop{}} = Shops.delete_shop(shop)
      assert_raise Ecto.NoResultsError, fn -> Shops.get_shop!(shop.id) end
    end

    test "change_shop/1 returns a shop changeset" do
      shop = shop_fixture()
      assert %Ecto.Changeset{} = Shops.change_shop(shop)
    end
  end
end
