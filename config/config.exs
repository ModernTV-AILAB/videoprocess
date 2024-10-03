# config/config.exs

import Config

config :porcelain, driver: Porcelain.Driver.Basic

config :logger,
  backends: [{LoggerFileBackend, :error_log}]

config :logger, :error_log,
  # Specify the path to your log file
  path: "log/error.log",
  # Specify the log level (e.g., :debug, :info, :warn, :error)
  level: :error,
  # Optional format
  format: "$date $time [$level] $metadata$message\n",
  # Optional metadata
  metadata: [:request_id]
