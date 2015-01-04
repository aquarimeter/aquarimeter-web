
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

file = File.expand_path('../../readings.csv', __FILE__)
require 'csv'
CSV.foreach(file) do |row|
  temp = row[0].to_f
  ph = row[1].to_f
  SensorReading.create!(aquarium_id:1, temperature:temp, ph:ph)
  # Kernel.sleep(1) # add some latency...this is so I can graph over time and calculate mock avgs
end