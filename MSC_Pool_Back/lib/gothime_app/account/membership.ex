defmodule TimeManagerModule.Account.Membership do
  use Ecto.Schema
  import Ecto.Changeset

  schema "memberships" do
    # Associations
    belongs_to(:team, TimeManagerModule.Account.Team)
    belongs_to(:user, TimeManagerModule.Account.User)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(membership, attrs) do
    membership
    |> cast(attrs, [:team_id, :user_id])
    |> validate_required([:team_id, :user_id])
  end
end
