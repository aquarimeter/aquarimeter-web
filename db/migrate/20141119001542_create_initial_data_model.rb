class CreateInitialDataModel < ActiveRecord::Migration
  def change
    create_table :aquariums do |t|
      t.references :users
      t.string :name, :unique =>  true
    end

    create_table :sensor_readings do |t|
      t.references :aquariums
      t.decimal :ph
      t.decimal :temperature
      t.datetime :timestamp
    end

    add_index :aquariums, :name
    add_index :aquariums, :users_id

    add_index :sensor_readings, :aquariums_id
  end
end
