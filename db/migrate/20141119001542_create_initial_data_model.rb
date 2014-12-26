class CreateInitialDataModel < ActiveRecord::Migration
  def change
    create_table :aquariums do |t|
      t.integer :user_id, :null => false
      t.string :name, :unique =>  true, :null => false
      t.decimal :ideal_temp_low, :null => false, precision: 5, scale: 2
      t.decimal :ideal_temp_high, :null => false, precision: 5, scale: 2      
      t.timestamps
    end

    create_table :sensor_readings do |t|
      t.integer :aquarium_id, :null => false
      t.decimal :ph, :null => false, precision: 5, scale: 2
      t.decimal :temperature, :null => false, precision: 5, scale: 2
      t.timestamps
    end

    create_table :images do |t|
      t.string :image, :null => false
      t.string :image, :null => false
      t.boolean :avatar, :null => false, :default => false
      t.belongs_to :aquarium, :null => false
      t.timestamps
    end


    add_index :images, :aquarium_id
    add_index :aquariums, :name
    add_index :aquariums, :user_id

    add_index :sensor_readings, :aquarium_id

  end
end
