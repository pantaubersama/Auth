class AddClusterCountsToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :clusters_count, :integer, default: 0
    add_column :categories, :description, :string
  end
end
