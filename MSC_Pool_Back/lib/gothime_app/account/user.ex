defmodule TimeManagerModule.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:username, :string)
    field(:role, :string)
    field(:email, :string)
    field(:is_visible, :boolean, default: false)
    field(:password_hash, :string)

    # Each manager user has one team
    has_one(:team, TimeManagerModule.Account.User, foreign_key: :user_id)

    # Associations for clocks and schedules
    has_many(:clocks, TimeManagerModule.Time.Clock)
    has_many(:schedules, TimeManagerModule.Time.Schedule)
    has_many(:memberships, TimeManagerModule.Account.Membership)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :is_visible, :role, :password_hash])
    |> validate_required([:username, :email, :role, :password_hash])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
