class CreateWordstadiumChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :wordstadium_challenges, id: :uuid do |t|
      t.string :invite_code
      t.string :twitter_uid
      t.string :user_id
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
