defmodule TimeManagerModuleWeb.MembershipJSON do
  alias TimeManagerModule.Account.Membership

  @doc """
  Renders a list of memberships.
  """
  def index(%{memberships: memberships}) do
    %{data: for(membership <- memberships, do: data(membership))}
  end

  @doc """
  Renders a single membership.
  """
  def show(%{membership: membership}) do
    %{data: data(membership)}
  end

  defp data(%Membership{} = membership) do
    %{
      id: membership.id,
      team_id: membership.team_id,
      user_id: membership.user_id
    }
  end
end
