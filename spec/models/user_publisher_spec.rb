require 'rails_helper'

RSpec.describe Publishers::User, type: :model do
  describe "Publish user to rabbitmq" do
    pending "add some examples to (or delete) #{__FILE__}"
    
    # it "success" do
    #   queue = Publishers::User.publish "user.changed", {id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"}
      
    #   expect(Publishers::User.connection.queue_exists? "user.changed").to be_truthy

    #   expect(queue.message_count).to eq(1)
      
    #   payload = queue.pop
    #   expect(queue.message_count).to eq(0)
    #   expect(JSON.parse(payload.last)["id"]).to eq("c9242c5a-805b-4ef5-b3a7-2a7f25785cc8")
    # end

    # # check bunny mock setting :(
    # it "success again" do
    #   queue = Publishers::User.publish "user.changed", {id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"}
    #   expect(Publishers::User.connection.queue_exists? "user.changed").to be_truthy

    #   expect(queue.message_count).to eq(1)
      
    #   payload = queue.pop
    #   expect(queue.message_count).to eq(0)
    #   expect(JSON.parse(payload.last)["id"]).to eq("c9242c5a-805b-4ef5-b3a7-2a7f25785cc8")
    # end

  end
end
