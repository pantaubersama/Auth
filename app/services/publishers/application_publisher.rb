module Publishers
  class ApplicationPublisher
    @@connection = (Bunny.new ENV["RABBITMQ_URL"], automatically_recover: false)

    # direct
    def self.push routing_key, message
      connetion.start
      channel = @@connection.create_channel
      queue = channel.queue(routing_key, durable: true)
      queue.publish(message.to_json, persistent: true)

      connetion.close
    end

    def self.connetion
      @@connection
    end

    def self.connection=(conn=nil)
      @@connection = conn
    end
    
  end
end