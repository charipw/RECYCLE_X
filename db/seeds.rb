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


boroughs = ["Westminster","Tower Hamlets", "Islington","Hammersmith and Fulham", "Hackney", "Greenwich", "Camden"]
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

User.create(email:"ben@test.com", password:"123456", borough_id:"1")
User.create(email:"pia@test.com", password:"123456", borough_id:"2")
User.create(email:"charleen@test.com", password:"123456", borough_id:"3")


puts "Users created"
