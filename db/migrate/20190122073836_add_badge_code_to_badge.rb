class AddBadgeCodeToBadge < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :code, :string
    add_column :badges, :namespace, :string
    add_index :badges, [:code, :namespace], unique: true
  end
end
