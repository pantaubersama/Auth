class AddDeletedAtToBadge < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :deleted_at, :datetime
    add_index :badges, :deleted_at
    add_column :badges, :hidden, :boolean, default: false
  end
end
