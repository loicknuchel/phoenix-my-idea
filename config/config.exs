# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :my_idea,
  ecto_repos: [MyIdea.Repo]

# Configures the endpoint
config :my_idea, MyIdeaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sXFfFNl1zwvAVyz0lIDPR3HACmVKQaxHgVfe+7b5NcWkmVijglebi04/ZdCeMuuY",
  render_errors: [view: MyIdeaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MyIdea.PubSub,
  live_view: [signing_salt: "FUlWl27N"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
