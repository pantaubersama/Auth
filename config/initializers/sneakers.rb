require 'sneakers'

$redis = Redis.new url: ENV['REDIS_SERVER_URL']

if Rails.env.development? || Rails.env.test?
  Sneakers.configure({})
else
  Sneakers.configure(
    amqp: ENV["RABBITMQ_URL"],
    daemonize: Rails.env.production? || Rails.env.staging?,
    workers: ENV["SNEAKERS_WORKERS_COUNT"].to_i || 3,
    log: ENV["SNEAKERS_LOG_FILE"],
    pid_path: ENV["SNEAKERS_PID_FILE"]
  )
end

Sneakers.logger.level = Logger::INFO