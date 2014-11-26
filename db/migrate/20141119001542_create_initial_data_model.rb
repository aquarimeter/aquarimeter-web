class CreateInitialDataModel < ActiveRecord::Migration
  def change
    create_table :aquariums do |t|
      t.references :users
      t.string :name, :unique =>  true, :null => false
      t.timestamps
    end

    create_table :sensor_readings do |t|
      t.references :aquariums
      t.decimal :ph, :null => false
      t.decimal :temperature, :null => false
      t.timestamps
    end

    create_table :images do |t|
      t.string :image, :null => false
      t.string :description, :null => false
      t.string :processed_image, :null => false
      t.string :unprocessed_image, :null => false
      t.boolean :avatar, :null => false, :default => false
      t.belongs_to :aquariums, :null => false
      t.timestamps
    end



    add_index :aquariums, :name
    add_index :aquariums, :users_id

    add_index :sensor_readings, :aquariums_id
  end
end
