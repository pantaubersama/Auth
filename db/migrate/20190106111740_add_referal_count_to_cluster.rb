class AddReferalCountToCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :clusters, :referal_count, :integer, default: 0
  end
end
