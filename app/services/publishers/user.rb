module Publishers
  class User

    def self.publish exchange, message = {}
      # grab the fanout exchange
      x = channel.fanout("auth.#{exchange}")
      queue = channel.queue(exchange, durable: true).bind("auth.#{exchange}")
      # and simply publish message
      x.publish(message.to_json)
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