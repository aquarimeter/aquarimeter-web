namespace :generate_random_sensor_data do
  task :seed, :environment do
    # This loads dummy ph and temperature data -- I don't have access to the aquarium currently -- Robert
    # Code should be self-documenting

    require 'csv'
    CSV.foreach('/home/rob/aquarimeter-web/readings.csv') do |row|
      temp = row[0].to_f
      ph = row[1].to_f
      SensorReading.create!(aquarium_id:1, temperature:temp, ph:ph)
      # Kernel.sleep(1) # add some latency...this is so I can graph over time and calculate mock avgs
    end
  end
end
