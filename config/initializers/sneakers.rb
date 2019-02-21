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
    pid_path: ENV["SNEAKERS_PID_FILE"],
    timeout_job_after: 60,
    prefetch: 10,
    threads: 10
  )
end

Sneakers.logger.level = Logger::INFO

module Sneakers
  module ActiveRecord
    module ConnectionManagement
      # https://github.com/jondot/sneakers/issues/302
      # https://github.com/rails/rails/commit/c7b7c6ad1c773102753f1a11b857d0e37ceb6a21
      def process_work(delivery_info, metadata, msg, handler)
        super
      ensure
        ::ActiveRecord::Base.clear_active_connections! unless Rails.env.test?
      end
    end
  end
end

module Sneakers
  module Worker
    logger.warn "Patch Sneakers::Worker to clear ActiveRecord connections"
    prepend Sneakers::ActiveRecord::ConnectionManagement
  end
end