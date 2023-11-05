defmodule TimeManagerModule.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerModule.Account` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique user username.
  """
  def unique_user_username, do: "some username#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        is_visible: true,
        password_hash: "some password_hash",
        role: "some role",
        username: unique_user_username()
      })
      |> TimeManagerModule.Account.create_user()

    user
  end

  @doc """
  Generate a unique team name.
  """
  def unique_team_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: unique_team_name()
      })
      |> TimeManagerModule.Account.create_team()

    team
  end

  @doc """
  Generate a membership.
  """
  def membership_fixture(attrs \\ %{}) do
    {:ok, membership} =
      attrs
      |> Enum.into(%{

      })
      |> TimeManagerModule.Account.create_membership()

    membership
  end
end
