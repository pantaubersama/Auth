class AddImageGrayToBadge < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :image_gray, :string
  end
end
