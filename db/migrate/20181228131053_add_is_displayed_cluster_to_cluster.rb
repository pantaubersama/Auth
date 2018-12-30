class AddIsDisplayedClusterToCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :clusters, :is_displayed, :boolean, default: false
    add_column :clusters, :image, :string
    add_column :clusters, :description, :text
    add_column :clusters, :category_id, :uuid
    add_column :clusters, :requester_id, :uuid
  end
end
