class AddNoteToVerification < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :note, :text
  end
end
