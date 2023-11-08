## lib/auth_me_web/controllers/session_controller.ex

defmodule TimeManagerModuleWeb.SessionController do
  use TimeManagerModuleWeb, :controller

  alias TimeManagerModule.Guardian

  action_fallback(TimeManagerModuleWeb.FallbackController)

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Guardian.authenticate(email, password) do
      {:ok, user, jwt} ->
        access_token = jwt

        {:ok, refresh_token, _claims} =
          Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {7, :day})

        conn
        # max_age in seconds
        |> put_resp_cookie("ruid", refresh_token, max_age: 7 * 24 * 60 * 60)
        |> put_status(:created)
        |> render("render_token.json", %{user: user, jwt: access_token})

      {:error, reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: to_string(reason)})
    end
  end

  def refresh(conn, _params) do
    refresh_token = Plug.Conn.get_req_cookie(conn, "ruid")

    case Guardian.exchange(refresh_token, "refresh", "access") do
      {:ok, _old_stuff, {new_access_token, _new_claims}} ->
        conn
        |> put_status(:created)
        |> json(TimeManagerModuleWeb.SessionJSON.render_token(jwt: new_access_token))

      {:error, reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: to_string(reason)})
    end
  end

  def logout(conn, _) do
    conn
    |> Plug.Conn.delete_resp_cookie("ruid")
    |> put_status(:ok)
    |> text("Log out successful.")
  end

  #   defp login_reply({:ok, user}, conn) do
  #     conn
  #     |> put_flash(:info, "Welcome back!")
  #     |> Guardian.Plug.sign_in(user)   #This module's full name is Auth.UserManager.Guardian.Plug,
  #     |> redirect(to: "/protected")    #and the arguments specified in the Guardian.Plug.sign_in()
  #   end                                #docs are not applicable here.

  #   defp login_reply({:error, reason}, conn) do
  #     conn
  #     |> put_flash(:error, to_string(reason))
  #     |> new(%{})
  #   end
end
