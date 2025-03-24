# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Deleting all drivers..."
Driver.destroy_all

puts "Fetching drivers..."
url = "https://api.jolpi.ca/ergast/f1/#{Time.now.year}/drivers/"
response = HTTPX.get(url)
parsed_response = JSON.parse(response.body, symbolize_names: true)
drivers = parsed_response[:MRData][:DriverTable][:Drivers]

puts "Creating drivers in database..."
drivers.each do |driver|
  new_driver = Driver.find_or_create_by!(api_id: driver[:driverId])
  new_driver.update(
    first_name: driver[:givenName],
    last_name: driver[:familyName],
    number: driver[:permanentNumber].to_i,
    code: driver[:code]
  )
  new_driver.save!
  puts "✅ Created #{new_driver.first_name} #{new_driver.last_name}"
end

puts "Done!"
