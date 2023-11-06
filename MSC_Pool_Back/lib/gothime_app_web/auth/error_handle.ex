
defmodule TimeManagerModuleWeb.Auth.ErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do
    conn
    |> put_status(:unauthorized)
    |> json(%{error: "#{type}: #{to_string(reason)}"})
  end
end
