class AddImageToAquarium < ActiveRecord::Migration
  def change
    add_column :aquariums, :image, :string
  end
end
