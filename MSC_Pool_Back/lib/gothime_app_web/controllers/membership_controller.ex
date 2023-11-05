defmodule TimeManagerModuleWeb.MembershipController do
  use TimeManagerModuleWeb, :controller

  alias TimeManagerModule.Account
  alias TimeManagerModule.Account.Membership

  action_fallback(TimeManagerModuleWeb.FallbackController)

  def index(conn, _params) do
    memberships = Account.list_memberships()
    render(conn, :index, memberships: memberships)
  end

  def create(conn, %{"membership" => membership_params}) do
    with {:ok, %Membership{} = membership} <- Account.create_membership(membership_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/memberships/#{membership}")
      |> render(:show, membership: membership)
    end
  end

  def show(conn, %{"id" => id}) do
    membership = Account.get_membership!(id)
    render(conn, :show, membership: membership)
  end

  def update(conn, %{"id" => id, "membership" => membership_params}) do
    membership = Account.get_membership!(id)

    with {:ok, %Membership{} = membership} <-
           Account.update_membership(membership, membership_params) do
      render(conn, :show, membership: membership)
    end
  end

  def delete(conn, %{"id" => id}) do
    membership = Account.get_membership!(id)

    with {:ok, %Membership{}} <- Account.delete_membership(membership) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_memberships_by_user(conn, %{"userID" => userID}) do
    case Account.get_memberships_by_user(userID) do
      {:ok, memberships} ->
        render(conn, :index, memberships: memberships)

      {:error, reason} ->
        json(conn, %{error: reason})
    end
  end

  def get_memberships_by_team(conn, %{"teamID" => teamID}) do
    case Account.get_memberships_by_team(teamID) do
      {:ok, memberships} ->
        render(conn, :index, memberships: memberships)

      {:error, reason} ->
        json(conn, %{error: reason})
    end
  end
end
