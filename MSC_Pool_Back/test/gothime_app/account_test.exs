defmodule TimeManagerModule.AccountTest do
  use TimeManagerModule.DataCase

  alias TimeManagerModule.Account

  describe "users" do
    alias TimeManagerModule.Account.User

    import TimeManagerModule.AccountFixtures

    @invalid_attrs %{username: nil, role: nil, email: nil, is_visible: nil, password_hash: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{username: "some username", role: "some role", email: "some email", is_visible: true, password_hash: "some password_hash"}

      assert {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.username == "some username"
      assert user.role == "some role"
      assert user.email == "some email"
      assert user.is_visible == true
      assert user.password_hash == "some password_hash"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{username: "some updated username", role: "some updated role", email: "some updated email", is_visible: false, password_hash: "some updated password_hash"}

      assert {:ok, %User{} = user} = Account.update_user(user, update_attrs)
      assert user.username == "some updated username"
      assert user.role == "some updated role"
      assert user.email == "some updated email"
      assert user.is_visible == false
      assert user.password_hash == "some updated password_hash"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "teams" do
    alias TimeManagerModule.Account.Team

    import TimeManagerModule.AccountFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Account.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Account.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %Team{} = team} = Account.create_team(valid_attrs)
      assert team.name == "some name"
      assert team.description == "some description"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Team{} = team} = Account.update_team(team, update_attrs)
      assert team.name == "some updated name"
      assert team.description == "some updated description"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_team(team, @invalid_attrs)
      assert team == Account.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Account.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Account.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Account.change_team(team)
    end
  end

  describe "memberships" do
    alias TimeManagerModule.Account.Membership

    import TimeManagerModule.AccountFixtures

    @invalid_attrs %{}

    test "list_memberships/0 returns all memberships" do
      membership = membership_fixture()
      assert Account.list_memberships() == [membership]
    end

    test "get_membership!/1 returns the membership with given id" do
      membership = membership_fixture()
      assert Account.get_membership!(membership.id) == membership
    end

    test "create_membership/1 with valid data creates a membership" do
      valid_attrs = %{}

      assert {:ok, %Membership{} = membership} = Account.create_membership(valid_attrs)
    end

    test "create_membership/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_membership(@invalid_attrs)
    end

    test "update_membership/2 with valid data updates the membership" do
      membership = membership_fixture()
      update_attrs = %{}

      assert {:ok, %Membership{} = membership} = Account.update_membership(membership, update_attrs)
    end

    test "update_membership/2 with invalid data returns error changeset" do
      membership = membership_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_membership(membership, @invalid_attrs)
      assert membership == Account.get_membership!(membership.id)
    end

    test "delete_membership/1 deletes the membership" do
      membership = membership_fixture()
      assert {:ok, %Membership{}} = Account.delete_membership(membership)
      assert_raise Ecto.NoResultsError, fn -> Account.get_membership!(membership.id) end
    end

    test "change_membership/1 returns a membership changeset" do
      membership = membership_fixture()
      assert %Ecto.Changeset{} = Account.change_membership(membership)
    end
  end
end
