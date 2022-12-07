# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'
require 'open-uri'
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
Item.destroy_all
puts "Destroying Item"




# Packaging.create(
#   [
#     {category: "Rigid plastic", type: "PET", examples: "Drinks bottles. Clear trays. Sauce bottles"},
#     {category: "Rigid plastic", type: "HDPE", examples: "Milk bottles, bleach, cleaners, shampoo bottles"},
#     {category: "Rigid plastic", type: "PP", examples: "Plastic lids, margarine tubs, microwable meal trays"},
#     {category: "Rigid plastic", type: "PVC", examples: "Pipes, fittings, window and door frames"},
#     {category: "Rigid plastic", type: "Polystyrene", examples: "Foam packaging, meat trays, takeaway food containers"},
#     {category: "Rigid plastic", type: "Mixed Plastic", examples: "Pouches for baby food, pet food, detergent or cleaning. Cheese packaging"},
#     {category: "Plastic film", type: "Mixed Plastic Film", examples: "Crisp and sweet packets, pouches and plastic foils. Cheese wrappers"},
#     {category: "Plastic film", type: "HDPE Film", examples: "Cereal box boags and reusable carrier bags"},
#     {category: "Plastic film", type: "LDPE", examples: "Carrier bags, salad bags, bread bags, food bags, packaging films"},
#     {category: "Plastic film", type: "PP Film", examples: "Film lids from trays, salad bags, film seals on tubs"},
#     {category: "Glass", type: "Glass", examples: "Beer and wine bottles, jars, oil bottles"},
#     {category: "Metals", type: "Aluminium", examples: "Fizzy drinks cans, tin foil"},
#     {category: "Metals", type: "Foil", examples: "Kitchen foil, foil trays and bottle toppers"},
#     {category: "Metals", type: "Steel", examples: "Tins of sardines, soups, tuna"},
#     {category: "Paper", type: "Paper", examples: "Letters, envelopes, documents, pulped paper egg cartons"},
#     {category: "Paper", type: "Card", examples: "Careal boxes, loo roll tubes, delivery boxes"},
#     {category: "Biodegradable", type: "Compostable", examples: "Plant based compostable packaging"},
#     {category: "Biodegradable", type: "Biodegradable", examples: "Material that will break down naturally"},
#     {category: "Other", type: "Composite", examples: "Juice and milk cartons"},
#   ]
# )

PET = Packaging.create(category: "Rigid plastic", type: "PET", examples: "Drinks bottles. Clear trays. Sauce bottles")
HDPE = Packaging.create(category: "Rigid plastic", type: "HDPE", examples: "Milk bottles, bleach, cleaners, shampoo bottles")
PP = Packaging.create(category: "Rigid plastic", type: "PP", examples: "Plastic lids, margarine tubs, microwable meal trays")
PVC = Packaging.create(category: "Rigid plastic", type: "PVC", examples: "Pipes, fittings, window and door frames")
Polystyrene = Packaging.create(category: "Rigid plastic", type: "Polystyrene", examples: "Foam packaging, meat trays, takeaway food containers")
Mixed_plastic = Packaging.create(category: "Rigid plastic", type: "Mixed Plastic", examples: "Pouches for baby food, pet food, detergent or cleaning. Cheese packaging")
Mixed_plastic_film = Packaging.create(category: "Plastic film", type: "Mixed Plastic Film", examples: "Crisp and sweet packets, pouches and plastic foils. Cheese wrappers")
HDPE_film = Packaging.create(category: "Plastic film", type: "HDPE Film", examples: "Cereal box bags and reusable carrier bags")
LDPE = Packaging.create(category: "Plastic film", type: "LDPE", examples: "Carrier bags, salad bags, bread bags, food bags, packaging films")
PP_film = Packaging.create(category: "Plastic film", type: "PP Film", examples: "Film lids from trays, salad bags, film seals on tubs")
Glass = Packaging.create(category: "Glass", type: "Glass", examples: "Beer and wine bottles, jars, oil bottles")
Aluminium = Packaging.create(category: "Metals", type: "Aluminium", examples: "Fizzy drinks cans, tin foil")
Foil = Packaging.create(category: "Metals", type: "Foil", examples: "Kitchen foil, foil trays and bottle toppers")
Steel = Packaging.create(category: "Metals", type: "Steel", examples: "Tins of sardines, soups, tuna")
Paper = Packaging.create(category: "Paper", type: "Paper", examples: "Letters, envelopes, documents, pulped paper egg cartons")
Card = Packaging.create(category: "Paper", type: "Card", examples: "Cereal boxes, loo roll tubes, delivery boxes")
Compostable = Packaging.create(category: "Biodegradable", type: "Compostable", examples: "Plant based compostable packaging")
Biodegradable = Packaging.create(category: "Biodegradable", type: "Biodegradable", examples: "Material that will break down naturally")
Composite = Packaging.create(category: "Other", type: "Composite", examples: "Juice and milk cartons")

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
user_4 = User.create(email:"matteo@test.com", password:"123456", borough: Borough.all.sample)
user_5 = User.create(email:"lara@test.com", password:"123456", borough: Borough.all.sample)
user_6 = User.create(email:"amie@test.com", password:"123456", borough: Borough.all.sample)



puts "Users created"

item_1 = Item.create(eco_score: "A", name: "Whitworths sweet figs", barcode: "5000234047296" )
f = URI.open("https://www.bestwaywholesale.co.uk/img/products/1000/6/5000234047296.jpg")
p f
item_1.photo.attach(io: f, filename: "figs.jpg", content_type: "image/jpg" )
item_1.save!

item_2 = Item.create(eco_score: "B", name: "Marmite", barcode: "50184453" )
f = URI.open("https://www.fruit4london.co.uk/wp-content/uploads/2020/10/Marmite-Vegan-Spread_____2.jpg")
p f
item_2.photo.attach(io: f, filename: "marmite.jpg", content_type: "image/jpg" )
item_2.save!

item_3 = Item.create(eco_score: "", name: "Fanta", barcode: "5449000011527" )
f = URI.open("https://www.yummiesdeli.com/wp-content/uploads/2020/04/Fanta-Orange-Can-scaled.jpg")
p f
item_3.photo.attach(io: f, filename: "fanta.jpg", content_type: "image/jpg" )
item_3.save!

item_4 = Item.create(eco_score: "", name: "Nutella", barcode: "3017620422003" )
f = URI.open("https://vicofoodbox.com/wp-content/uploads/2021/06/BL077.jpg")
p f
item_4.photo.attach(io: f, filename: "nutella.jpg", content_type: "image/jpg" )
item_4.save!

item_5 = Item.create(eco_score: "", name: "Coke", barcode: "04965802" )
f = URI.open("https://images.openfoodfacts.org/images/products/04965802/front_en.17.400.jpg")
p f
item_5.photo.attach(io: f, filename: "coke.jpg", content_type: "image/jpg" )
item_5.save!

item_6 = Item.create(eco_score: "A", name: "Granola", barcode: "5060419540127" )
f = URI.open("https://images.openfoodfacts.org/images/products/506/041/954/0127/front_en.3.400.jpg")
p f
item_6.photo.attach(io: f, filename: "granola.jpg", content_type: "image/jpg" )
item_6.save!

item_7 = Item.create(eco_score: "A", name: "Peroni", barcode: "8008440222008" )
f = URI.open("https://www.clickndrink.co.uk/wp-content/uploads/2020/03/26690043-1.jpg")
p f
item_7.photo.attach(io: f, filename: "peroni.jpg", content_type: "image/jpg" )
item_7.save!

item_8 = Item.create(eco_score: "B", name: "Pop Chips", barcode: "5060292302256" )
f = URI.open("https://images.openfoodfacts.org/images/products/506/029/230/2256/front_en.24.400.jpg")
p f
item_8.photo.attach(io: f, filename: "popchips.jpg", content_type: "image/jpg" )
item_8.save!

item_9 = Item.create(eco_score: "B", name: "M&S Hummous", barcode: "00348423" )
f = URI.open("https://images.openfoodfacts.org/images/products/00348423/front_fr.4.400.jpg")
p f
item_9.photo.attach(io: f, filename: "hummus.jpg", content_type: "image/jpg" )
item_9.save!

item_10 = Item.create(eco_score: "B", name: "Activia", barcode: "0056800098297" )
f = URI.open("https://images.openfoodfacts.org/images/products/005/680/009/8297/front_en.38.400.jpg")
p f
item_10.photo.attach(io: f, filename: "activia.jpg", content_type: "image/jpg" )
item_10.save!




puts "Items created"

ItemUser.create(user_id: user_3.id, item_id: item_1.id)
ItemUser.create(user_id: user_3.id, item_id: item_2.id)
ItemUser.create(user_id: user_1.id, item_id: item_3.id)
ItemUser.create(user_id: user_3.id, item_id: item_4.id)
ItemUser.create(user_id: user_3.id, item_id: item_5.id)
ItemUser.create(user_id: user_3.id, item_id: item_6.id)
ItemUser.create(user_id: user_3.id, item_id: item_7.id)
ItemUser.create(user_id: user_3.id, item_id: item_8.id)
ItemUser.create(user_id: user_3.id, item_id: item_9.id)
ItemUser.create(user_id: user_3.id, item_id: item_10.id)


200.times do
  user = [user_1, user_2, user_4, user_5, user_6].sample
  item = [item_1, item_2, item_3, item_4, item_5, item_6, item_7, item_8, item_9, item_10].sample
  ItemUser.create(user_id: user.id, item_id: item.id)
end


puts "Items Users created"

ItemPackaging.create(packaging: LDPE, item_id: item_1.id)
ItemPackaging.create(packaging: Glass, item_id: item_2.id)
ItemPackaging.create(packaging: PP, item_id: item_2.id)
ItemPackaging.create(packaging: Aluminium, item_id: item_3.id)
ItemPackaging.create(packaging: PP, item_id: item_4.id)
ItemPackaging.create(packaging: Foil, item_id: item_4.id)
ItemPackaging.create(packaging: Card, item_id: item_4.id)
ItemPackaging.create(packaging: Glass, item_id: item_4.id)
ItemPackaging.create(packaging: Aluminium, item_id: item_5.id)
ItemPackaging.create(packaging: Card, item_id: item_6.id)
ItemPackaging.create(packaging: HDPE_film, item_id: item_6.id)
ItemPackaging.create(packaging: Glass, item_id: item_7.id)
ItemPackaging.create(packaging: LDPE, item_id: item_8.id)
ItemPackaging.create(packaging: PP, item_id: item_9.id)
ItemPackaging.create(packaging: PP, item_id: item_10.id)



puts "Item Packaging created"
