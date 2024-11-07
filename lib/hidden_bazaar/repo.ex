defmodule HiddenBazaar.Repo do
  use Ecto.Repo,
    otp_app: :hidden_bazaar,
    adapter: Ecto.Adapters.Postgres
end
