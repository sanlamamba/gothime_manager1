## lib/auth_me_web/controllers/session_controller.ex

defmodule TimeManagerModuleWeb.Auth.SessionController do
  use TimeManagerModuleWeb, :controller

  alias TimeManagerModuleWeb.{User, Account.User, TimeManagerModule.Guardian}


  def login(conn, %{"user" => %{"email" => email, "password_hash" => password}}) do
    case UserManager.authenticate_user(email, password) do
      {:ok, user} ->
        token = Guardian.Plug.api_sign_in(conn, user)
        json(conn, %{jwt: token, user: user})
      {:error, reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: to_string(reason)})
    end
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out() #This module's full name is Auth.UserManager.Guardian.Plug,
    |> redirect(to: "/login")   #and the arguments specified in the Guardian.Plug.sign_out()
  end                           #docs are not applicable here

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, "Welcome back!")
    |> Guardian.Plug.sign_in(user)   #This module's full name is Auth.UserManager.Guardian.Plug,
    |> redirect(to: "/protected")    #and the arguments specified in the Guardian.Plug.sign_in()
  end                                #docs are not applicable here.

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
