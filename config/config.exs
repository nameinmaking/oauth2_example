# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :oauth2_example,
  ecto_repos: [Oauth2Example.Repo]

# Configures the endpoint
config :oauth2_example, Oauth2ExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SJRuAx5yBkVbjxD1ckjDFti8sAgAm2C7zJm4IxZPyCHxqrcM3cehwYZd+lyAJKUm",
  render_errors: [view: Oauth2ExampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Oauth2Example.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [] }
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "96dd97e0714b2400543a",
  client_secret: "fc0918c56532bdddb9ce27a56904e5871c455715"
