# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[ "TIA", "EZE", "AUA", "BNE", "CBR", "OOL", "DRW", "MEL", "GGT", "FLN" ].each do |code|
  Airport.create(code: code)
end

flight_seed = []
10.times do |i|
  departure_id = Random.rand(1..10)
  arrival_id = Random.rand(1..10)
  until arrival_id != departure_id
    arrival_id = Random.rand(1..10)
  end
  flight_seed << {
    start: DateTime.new(Time.now.year + 1, Random.rand(1..12), Random.rand(1..28), Random.rand(0..23), Random.rand(0..59)),
    duration: Random.rand(1..19),
    departure_airport_id: departure_id,
    arrival_airport_id: arrival_id
  }
end

flight_seed.each do |flight|
  Flight.create(start: flight[:start], duration: flight[:duration], departure_airport_id: flight[:departure_airport_id], arrival_airport_id: flight[:arrival_airport_id])
end
