class AddAvatarsToAquariums < ActiveRecord::Migration
  def change
    add_column :aquariums, :avatars, :json
  end
end
