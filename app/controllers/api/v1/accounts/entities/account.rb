module API::V1::Accounts::Entities
  class Account < Grape::Entity
    expose :id
    expose :account_type
    expose :user, using: Api::V1::Me::Entities::UserSimple
  end
end