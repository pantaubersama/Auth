module API::V1::Clusters::Entities
  class Cluster < API::V1::Clusters::Entities::ClusterSimple
    expose :name, documentation: {desc: "Name", required: true}
    expose :category_id, documentation: {desc: "Category ID", required: true}
    expose :category, using: API::V1::Categories::Entities::Category
    expose :description, documentation: {desc: "Description"}
    expose :image, documentation: {desc: "Image", type: File}
  end
end