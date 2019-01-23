class AddNumberToPoliticalParty < ActiveRecord::Migration[5.2]
  def change
    add_column :political_parties, :number, :integer, default: 0
  end
end
