class AddIsEligibleToCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :clusters, :is_eligible, :boolean, default: false
  end
end
