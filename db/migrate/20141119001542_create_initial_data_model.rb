class CreateInitialDataModel < ActiveRecord::Migration
  def change
    create_table :aquariums do |t|
      t.references :users
      t.string :name, :unique =>  true
      t.timestamps
    end

    create_table :sensor_readings do |t|
      t.references :aquariums
      t.decimal :ph
      t.decimal :temperature
      t.timestamps
    end

    create_table :images do |t|
      t.string :image
      t.string :description
      t.string :processed_image
      t.string :unprocessed_image
      t.boolean :avatar
      t.belongs_to :aquariums
      t.timestamps
    end



    add_index :aquariums, :name
    add_index :aquariums, :users_id

    add_index :sensor_readings, :aquariums_id
  end
end
