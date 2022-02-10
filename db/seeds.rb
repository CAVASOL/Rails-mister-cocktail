# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'
require 'json'
require 'yaml'

puts 'Cleaning up database...'
Cocktail.destroy_all
puts 'Database cleaned'

url = 'http://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{query}'
JSON.parse(URI.parse(url).open.read)['drinks'].each do |ingredient|
  new_ingredient = Ingredient.create(name: ingredient['strIngredient'])
  new_ingredient.save!
end
