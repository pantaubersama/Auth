class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :image
      t.integer :star, default: 0
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
