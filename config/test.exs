import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :miniapp_svg_inside_table, MiniappSvgInsideTable.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "miniapp_svg_inside_table_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :miniapp_svg_inside_table, MiniappSvgInsideTableWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "eCaDM3+/HnMc6ZboyUgW6KKIk1+aSkQKjRdY3uB2hbA0n9s751oRS+jLQE0HQwpe",
  server: false

# In test we don't send emails.
config :miniapp_svg_inside_table, MiniappSvgInsideTable.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
