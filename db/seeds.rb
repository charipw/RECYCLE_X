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
ItemPackaging.destroy_all
puts "Destroying Item Packagings"
Packaging.destroy_all
puts "Destroying Packagings"
ItemUser.destroy_all
puts "Destroying Item User"





Packaging.create(
  [
    {category: "Rigid plastic", type: "PET", examples: "Drinks bottles. Clear trays. Sauce bottles"},
    {category: "Rigid plastic", type: "HDPE", examples: "Milk bottles, bleach, cleaners, shampoo bottles"},
    {category: "Rigid plastic", type: "PP", examples: "Plastic lids, margarine tubs, microwable meal trays"},
    {category: "Rigid plastic", type: "PVC", examples: "Pipes, fittings, window and door frames"},
    {category: "Rigid plastic", type: "Polystyrene", examples: "Foam packaging, meat trays, takeaway food containers"},
    {category: "Rigid plastic", type: "Mixed Plastic", examples: "Pouches for baby food, pet food, detergent or cleaning. Cheese packaging"},
    {category: "Plastic film", type: "Mixed Plastic Film", examples: "Crisp and sweet packets, pouches and plastic foils. Cheese wrappers"},
    {category: "Plastic film", type: "HDPE Film", examples: "Cereal box boags and reusable carrier bags"},
    {category: "Plastic film", type: "LDPE", examples: "Carrier bags, salad bags, bread bags, food bags, packaging films"},
    {category: "Plastic film", type: "PP Film", examples: "Film lids from trays, salad bags, film seals on tubs"},
    {category: "Glass", type: "Glass", examples: "Beer and wine bottles, jars, oil bottles"},
    {category: "Metals", type: "Aluminium", examples: "Fizzy drinks cans, tin foil"},
    {category: "Metals", type: "Foil", examples: "Kitchen foil, foil trays and bottle toppers"},
    {category: "Metals", type: "Steel", examples: "Tins of sardines, soups, tuna"},
    {category: "Paper", type: "Paper", examples: "Letters, envelopes, documents, pulped paper egg cartons"},
    {category: "Paper", type: "Card", examples: "Careal boxes, loo roll tubes, delivery boxes"},
    {category: "Biodegradable", type: "Compostable", examples: "Plant based compostable packaging"},
    {category: "Biodegradable", type: "Biodegradable", examples: "Material that will break down naturally"},
    {category: "Other", type: "Composite", examples: "Juice and milk cartons"},
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


puts "Rules created"


user_1 = User.create(email: "ben@test.com", password: "123456", borough: Borough.all.sample)
user_2 = User.create(email: "pia@test.com", password: "123456", borough: Borough.all.sample)
user_3 = User.create(email:"charleen@test.com", password:"123456", borough: Borough.all.sample)


puts "Users created"

item_1 = Item.create(eco_score: "A", name: "Whitworths sweet figs", barcode: "5000234047296" )
image = File.open("app/assets/images/Figs.jpeg")
item_1.photo.attach(io: image, filename:"Figs.jpeg", )
item_1.save

item_2 = Item.create(name: "Marmite", barcode: "50184453" )
image = File.open("app/assets/images/Marmite.jpeg")
item_2.photo.attach(io: image, filename:"Marmite.jpeg", )
item_2.save


puts "Items created"

ItemUser.create(user_id: user_3.id, item_id: item_1.id)
ItemUser.create(user_id: user_3.id, item_id: item_2.id)



puts "Items Users created"

ItemPackaging.create(packaging: Packaging.second, item_id: item_1.id)
ItemPackaging.create(packaging: Packaging.second, item_id: item_2.id)


puts "Item Packaging created"
