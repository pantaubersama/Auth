class AddIsLinkActiveToCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :clusters, :is_link_active, :boolean, default: false
    add_column :clusters, :magic_link, :string
  end
end
