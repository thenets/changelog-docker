use Mix.Config

config :changelog, ChangelogWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "changelog.com", port: 443],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  static_url: [scheme: "https", host: "cdn.changelog.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info
# config :logger, :console, level: :debug, format: "[$level] $message\n"

config :arc,
  storage_dir: "/uploads"

config :changelog, Changelog.Repo,
  url: {:system, "DB_URL"},
  adapter: Ecto.Adapters.Postgres,
  pool_size: 20

config :changelog, Changelog.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: {:system, "SMTP_SERVER"},
  hostname: {:system, "SMTP_HOSTNAME"},
  port: 465,
  username: {:system, "SMTP_USERNAME"},
  password: {:system, "SMTP_PASSWORD"},
  tls: :if_available,
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"],
  ssl: true,
  retries: 1

config :changelog, Changelog.Scheduler,
  global: true,
  timezone: "US/Central",
  jobs: [
    {"0 4 * * *", {Changelog.Stats, :process, []}},
    {"0 3 * * *", {Changelog.Slack.Tasks, :import_member_ids, []}},
    {"* * * * *", {Changelog.NewsQueue, :publish, []}}
  ]

config :rollbax,
  access_token: {:system, "ROLLBAR_ACCESS_TOKEN"},
  environment: "production"
