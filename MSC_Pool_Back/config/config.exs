# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :gothime_app,
  namespace: TimeManagerModule,
  ecto_repos: [TimeManagerModule.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :gothime_app, TimeManagerModuleWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: TimeManagerModuleWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TimeManagerModule.PubSub,
  live_view: [signing_salt: "+pTfwwyv"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

#Set up Guardian
config :gothime_app, TimeManager.Guardian,
       issuer: "gothime_app",
       secret_key: "jXQ6BMh5cFTOMCdCzbDc48zqsBQuWXfthC9vP7+uF63gcwJvcunOcGEXgShVPDwt"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
