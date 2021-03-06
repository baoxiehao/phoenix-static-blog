# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :static_blog, StaticBlog.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cCtCA1PFzLLfkdG3QL8kcjvGSHasQZju0emkMKUQLRf3IUgkUfEHoih5+cfaZZjM",
  render_errors: [view: StaticBlog.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StaticBlog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
