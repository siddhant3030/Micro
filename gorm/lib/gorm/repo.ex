defmodule Gorm.Repo do
  use Ecto.Repo,
    otp_app: :gorm,
    adapter: Ecto.Adapters.Postgres
end
