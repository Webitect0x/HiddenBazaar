defmodule HiddenBazaar.Shops.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  alias HiddenBazaar.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "shops" do
    field :name, :string
    field :description, :string
    field :shop_avatar, :string
    field :shop_banner, :string

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:name, :description, :shop_avatar, :shop_banner, :user_id])
    |> validate_required([:name, :description, :user_id])
  end
end
