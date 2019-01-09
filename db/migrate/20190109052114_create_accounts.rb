class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts, id: :uuid do |t|
      t.integer :account_type
      t.text :access_token
      t.text :access_token_secret
      t.string :uid
      t.string :email
      t.uuid :user_id

      t.timestamps
    end
  end
end
