# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
boroughs = ["Westminster", "Wandsworth", "Waltham Forest", "Tower Hamlets", "Sutton", "Southwark", "Richmond upon Thames", "Redbridge", "Newham", "Merton", "Lewisham", "Lambeth", "Kingston upon Thames", "Kensington and Chelsea", "Islington", "Hounslow", "Hillingdon", "Havering", "Harrow", "Haringey", "Hammersmith and Fulham", "Hackney", "Greenwich", "Enfield", "Ealing", "Croydon", "Camden", "Bromley", "Brent", "Bexley", "Barnet", "Barking and Dagenham"]
boroughs.each do |b|
  Borough.create(name: b)
end

User.create(email:"ben@test.com", password:"123456", borough_id:"1")
