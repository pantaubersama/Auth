class AddCreatorIdToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :creator_id, :uuid
  end
end
