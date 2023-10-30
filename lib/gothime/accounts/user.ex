defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :is_visible, :boolean, default: false
    field :team_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :is_visible])
    |> validate_required([:username, :email, :is_visible])
    |> unique_constraint(:email)
  end
end
