class CreateVerifications < ActiveRecord::Migration[5.2]
  def change
    create_table :verifications, id: :uuid do |t|
      t.uuid :user_id
      t.string :ktp_number
      t.string :ktp_photo
      t.string :ktp_selfie
      t.string :signature
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
