module API::V1::Badges::Entities
  class Badge < Grape::Entity
    expose :id
    expose :name
    expose :description
    expose :image
    expose :image_gray
    expose :position
    expose :code, if: lambda { |c,o| o[:current_user].present? && o[:current_user].is_admin? }
    expose :namespace, if: lambda { |c,o| o[:current_user].present? && o[:current_user].is_admin? }
  end
end