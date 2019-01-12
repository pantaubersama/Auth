class AddDeletedAtToCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :clusters, :deleted_at, :datetime
    add_index :clusters, :deleted_at
  end
end
