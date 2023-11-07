defmodule TimeManager.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :gothime_app, module: TimeManager.Guardian, error_handler: TimeManager.Guardian.AuthErrorHandler

  @claims %{typ: "access"}

  plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, ensure: true
end
