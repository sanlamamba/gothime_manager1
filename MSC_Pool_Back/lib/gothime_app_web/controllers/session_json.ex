defmodule TimeManagerModuleWeb.SessionJSON do
  alias TimeManagerModule.Account.User
  @doc """
  Renders JWT token data.
  """
  def render_token(%{user: user, jwt: jwt}) do
    %{
      token: jwt,
      user: user_data(user)
    }  end

  defp token_data(jwt) do
    %{
      token: jwt
    }
  end

  defp user_data(user) do

    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      is_visible: user.is_visible

    }
  end
end
