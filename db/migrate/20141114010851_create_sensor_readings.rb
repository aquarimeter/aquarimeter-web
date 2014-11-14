class CreateSensorReadings < ActiveRecord::Migration
  def change
    create_table :sensor_readings do |t|

      t.timestamps
    end
  end
end
