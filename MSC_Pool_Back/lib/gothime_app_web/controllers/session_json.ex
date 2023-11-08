defmodule TimeManagerModuleWeb.SessionJSON do
  @doc """
  Renders JWT token data.
  """
  def render_token(%{jwt: jwt}) do
    %{data: token_data(jwt)}
  end

  defp token_data(jwt) do
    %{
      token: jwt
    }
  end
end
