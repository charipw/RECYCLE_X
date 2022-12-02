# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'
puts "Cleaning database..."


User.destroy_all
puts "Destroying Users"
Rule.destroy_all
puts "Destroying Rules"
Borough.destroy_all
puts "Destroying Boroughs"
Packaging.destroy_all
puts "Destroying Packagings"



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
puts "Packagings created"


boroughs = ["Westminster","Tower Hamlets", "Islington","Hammersmith and Fulham", "Hackney", "Greenwich", "Camden", "Kensington and Chelsea", "Lambeth", "Lewisham","Southwark", "Wandsworth"]
boroughs.each do |b|
  Borough.create(name: b)
end

puts "Boroughs created"

filepath = "./db/files/boroughs.csv"
CSV.foreach(filepath, headers: :first_row) do |row|
  puts "#{row['Borough']} #{row['Category']} #{row['Type']} can #{row['Recycled'] == "N" ? "not" :""} be recycled"
  b = Borough.find_by(name: row["Borough"])
  p b
  packaging = Packaging.find_by(category: row["Category"], type: row["Type"])
  p packaging
  Rule.create!( borough: b, packaging: packaging, is_recycled: row["Recycled"] == "N" ? false : true)
end

# Borough.all.each do |borough|
#   Packaging.all.each do |package|
#     Rule.create!( borough: borough, packaging: package )
#   end
# end

puts "Rules created"


user_1 = User.create(email: "ben@test.com", password: "123456", borough_id: "1")
user_2 = User.create(email: "pia@test.com", password: "123456", borough_id: "2")
user_3 = User.create(email:"charleen@test.com", password:"123456", borough_id:"3")


puts "Users created"

item_1 = Item.create(eco_score: "D", carbon_footprint: 2000, name: "Gatorade", barcode: "22222222" )
item_2 = Item.create(eco_score: "A", carbon_footprint: 40, name: "Leibniz Kekse", barcode: "22222222" )
item_3 = Item.create(eco_score: "C", carbon_footprint: 300, name: "Lays chips", barcode: "33333333" )
item_4 = Item.create(eco_score: "C", carbon_footprint: 500, name: "Pegroni", barcode: "22222222" )
item_5 = Item.create(eco_score: "B", carbon_footprint: 350, name: "Popchips", barcode: "5060292308104" )
item_6 = Item.create(eco_score: "A", carbon_footprint: 200, name: "Stemless sweet figs", barcode: "5000234047296" )


puts "Items created"

ItemUser.create(user_id: user_2.id, item_id: item_1.id)
ItemUser.create(user_id: user_1.id, item_id: item_1.id)
ItemUser.create(user_id: user_1.id, item_id: item_2.id)
ItemUser.create(user_id: user_1.id, item_id: item_3.id)
ItemUser.create(user_id: user_2.id, item_id: item_4.id)
ItemUser.create(user_id: user_3.id, item_id: item_3.id)
ItemUser.create(user_id: user_3.id, item_id: item_2.id)
ItemUser.create(user_id: user_3.id, item_id: item_5.id)
ItemUser.create(user_id: user_3.id, item_id: item_6.id)


puts "Items Users created"
