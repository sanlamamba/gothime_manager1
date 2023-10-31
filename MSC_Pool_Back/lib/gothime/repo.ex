defmodule TimeManager.Repo do
  use Ecto.Repo,
    otp_app: :gothime,
    adapter: Ecto.Adapters.Postgres
end
