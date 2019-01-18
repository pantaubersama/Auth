class CreatePoliticalParties < ActiveRecord::Migration[5.2]
  def change
    create_table :political_parties, id: :uuid do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
