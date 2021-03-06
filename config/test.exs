use Mix.Config

config :logger, :console,
  format: "\n$date $time [$level]: $message \n"

config :exq,
  name: Exq,
  host: String.to_char_list(System.get_env("REDIS_HOST") || "127.0.0.1"),
  port: String.to_integer(System.get_env("REDIS_PORT") || "6555"),
  url: nil,
  namespace: "test",
  queues: ["default"],
  concurrency: :infinite,
  scheduler_enable: false,
  scheduler_poll_timeout: 20,
  poll_timeout: 10,
  redis_timeout: 5000,
  genserver_timeout: 5000,
  test_with_local_redis: true,
  max_retries: 0,
  middleware: [Exq.Middleware.Stats, Exq.Middleware.Job, Exq.Middleware.Manager]
