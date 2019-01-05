class AddStatusToClusters < ActiveRecord::Migration[5.2]
  def change
    # [0 => :requested, 1 => :approved, 2 => :rejected]
    add_column :clusters, :status, :integer, default: 0, null: false
  end
end
