defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :is_visible, :boolean, default: true

    has_many :clocks, TimeManager.Time.Clock
    has_many :schedules, TimeManager.Time.Schedule

    belongs_to :team, TimeManager.Accounts.Team

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :is_visible, :team_id])
    |> validate_required([:username, :email, :is_visible])
    |> unique_constraint(:email)
  end
end
