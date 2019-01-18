class AddStatusToVerification < ActiveRecord::Migration[5.2]
  def change
    add_column :verifications, :status, :integer
  end
end
