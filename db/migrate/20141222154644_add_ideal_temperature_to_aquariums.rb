class AddIdealTemperatureToAquariums < ActiveRecord::Migration
  def change
    add_column :aquariums, :ideal_temperature, :decimal, precision: 5, scale: 2
  end
end
