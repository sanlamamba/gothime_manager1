defmodule TimeManager.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Accounts` context.
  """

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
      |> TimeManager.Accounts.create_team()

    team
  end

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        is_visible: true,
        username: "some username"
      })
      |> TimeManager.Accounts.create_user()

    user
  end
end
