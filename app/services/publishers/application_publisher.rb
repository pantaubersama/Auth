module Publishers
  class ApplicationPublisher
    def self.push exchange, message, server_code
      # grab the fanout exchange
      fanout = channel.fanout("#{server_code}.#{exchange}")
      queue  = channel.queue(exchange, durable: true).bind("#{server_code}.#{exchange}")
      # and simply publish message
      fanout.publish(message.to_json)
      queue
    end

    def self.channel
      @channel ||= connection.create_channel
    end

    def self.connection
      @connection ||= Bunny.new(ENV["RABBITMQ_URL"]).tap do |c|
        c.start
      end
    end

    def self.connection=(conn)
      @connection = conn
    end

  end
end