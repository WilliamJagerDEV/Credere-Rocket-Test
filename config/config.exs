# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :sonda_meu_credere, SondaMeuCredereWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "e8uYR3Pj2xpKWCGHuY/ZY7V0B5bQO+EiVHgutKtiQewom4gkdynSw0BdYmrRG/hx",
  render_errors: [view: SondaMeuCredereWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SondaMeuCredere.PubSub,
  live_view: [signing_salt: "RqEUCg47"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

if Mix.env() != :prod do
  config :git_hooks,
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          "mix clean",
          "mix format",
          "mix compile --warnings-as-errors",
          "mix credo --strict",
          "mix doctor --summary",
          "mix test",
          "mix format --check-formatted"
        ]
      ]
    ]
end

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
