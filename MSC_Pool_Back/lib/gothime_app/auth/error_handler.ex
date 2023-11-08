defmodule TimeManager.Guardian.AuthErrorHandler do
  alias TimeManager.Guardian
import Plug.Conn

@behaviour Guardian.ErrorHandler

@impl Guardian.Plug.ErrorHandler

def auth_error(conn, {type, _reason}, _opts) do
  body = Jason.encode!(%{error: to_string(type)})

  conn
  |> put_resp_content_type("application/json")
  |> send_resp(401, body)
end

end
