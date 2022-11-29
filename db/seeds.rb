# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning database..."


User.destroy_all
Borough.destroy_all


Packaging.create(
  [
    {category: "Rigid plastic", type: "PET"},
    {category: "Rigid plastic", type: "HDPE"},
    {category: "Rigid plastic", type: "PP"},
    {category: "Rigid plastic", type: "PVC"},
    {category: "Rigid plastic", type: "Polystyrene"},
    {category: "Rigid plastic", type: "Mixed Plastic"},
    {category: "Rigid plastic", type: "Other Plastic"},
    {category: "Plastic film", type: "Mixed Plastic"},
    {category: "Plastic film", type: "HDPE"},
    {category: "Plastic film", type: "LDPE"},
    {category: "Plastic film", type: "PP"},
    {category: "Glass", type: "Glass"},
    {category: "Metals", type: "Aluminium"},
    {category: "Metals", type: "Foil"},
    {category: "Metals", type: "Steel"},
    {category: "Paper", type: "Paper"},
    {category: "Paper", type: "Card"},
    {category: "Biodegradable", type: "Compostable"},
    {category: "Biodegradable", type: "Biodegradable"},
    {category: "Other", type: "Composite"},
    {category: "Other", type: "Unknown"},
  ]
)

boroughs = ["Westminster", "Wandsworth", "Waltham Forest", "Tower Hamlets", "Sutton", "Southwark", "Richmond upon Thames", "Redbridge", "Newham", "Merton", "Lewisham", "Lambeth", "Kingston upon Thames", "Kensington and Chelsea", "Islington", "Hounslow", "Hillingdon", "Havering", "Harrow", "Haringey", "Hammersmith and Fulham", "Hackney", "Greenwich", "Enfield", "Ealing", "Croydon", "Camden", "Bromley", "Brent", "Bexley", "Barnet", "Barking and Dagenham"]
boroughs.each do |b|
  Borough.create(name: b)
end

User.create(email:"ben@test.com", password:"123456", borough_id:"1")
User.create(email:"pia@test.com", password:"123456", borough_id:"2")
