defmodule HiddenBazaar.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string
      add :shop_avatar, :string
      add :shop_banner, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:shops, [:user_id])
  end
end
