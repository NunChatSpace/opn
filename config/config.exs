# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :reborn,
  ecto_repos: [Reborn.Repo]

# Configures the endpoint
config :reborn, RebornWeb.Endpoint,
  url: [host: "localhost:4000"],
  secret_key_base: "RDFBH0YLlD6BcoTabzxZ4HPINp/pt2NiAGrIcjJsqKsLkp/sVInRIBfO/gvPHaJL",
  render_errors: [view: RebornWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Reborn.PubSub,
  live_view: [signing_salt: "FIHpyCK3"]

# Configures the Guardian library
config :reborn, Reborn.Auth.Guardian,
  issuer: "Reborn",
  ttl: { 1, :days },
  allowed_drift: 2000,
  secret_key: "5ecret_k3y"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
