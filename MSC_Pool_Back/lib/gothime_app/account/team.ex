defmodule TimeManagerModule.Account.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field(:name, :string)
    field(:description, :string)

    # Each team is managed by one user
    belongs_to(:user, TimeManagerModule.Account.User, foreign_key: :user_id)

    has_many(:memberships, TimeManagerModule.Account.Membership)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :description, :user_id])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
