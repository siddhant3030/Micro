# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gorm,
  ecto_repos: [Gorm.Repo]

# Configures the endpoint
config :gorm, GormWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XIxmjyO9Ph3RS+VkeHabhakNFMza9PBuHlK/g6dZy51MqflaxUnK4qDx0ODMgn9y",
  render_errors: [view: GormWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Gorm.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :exq,
  name: Exq,
  host: "127.0.0.1",
  port: 6379,
  namespace: "exq",
  concurrency: 500,
  queues: ["q1"]

  config :exq_ui,
  web_port: 4040,
  web_namespace: "",
  server: true

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
