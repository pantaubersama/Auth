class CreateInformants < ActiveRecord::Migration[5.2]
  def change
    create_table :informants, id: :uuid do |t|
      t.uuid :user_id
      t.string :identity_number
      t.string :pob
      t.date :dob
      t.integer :gender
      t.string :occupation
      t.string :nationality
      t.text :address
      t.string :phone_number

      t.timestamps
    end
  end
end
