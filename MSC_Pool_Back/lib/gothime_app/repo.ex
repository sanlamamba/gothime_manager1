defmodule TimeManagerModule.Repo do
  use Ecto.Repo,
    otp_app: :gothime_app,
    adapter: Ecto.Adapters.Postgres
end
