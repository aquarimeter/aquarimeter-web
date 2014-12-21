class AddSnapshotsToAquariums < ActiveRecord::Migration
  def change
    add_column :aquariums, :snaoshots, :json
  end
end
