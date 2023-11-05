defmodule TimeManagerModule.Time.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedules" do
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime

    # Each schedule entry belongs to a user
    belongs_to :user, TimeManagerModule.Account.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:start_time, :end_time, :user_id])
    |> validate_required([:start_time, :end_time, :user_id])
  end
end
