class AddDeletedAtToVerification < ActiveRecord::Migration[5.2]
  def change
    add_column :verifications, :deleted_at, :datetime
    add_index :verifications, :deleted_at
  end
end
