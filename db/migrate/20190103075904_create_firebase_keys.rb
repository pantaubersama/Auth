class CreateFirebaseKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :firebase_keys, id: :uuid do |t|
      t.text :content
      t.integer :key_type
      t.uuid :user_id, index: true

      t.timestamps
    end
  end
end
