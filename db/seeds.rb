# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

Cocktail.destroy_all
Ingredient.destroy_all

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
cocktail_db_serialized = open(url).read
cocktail_db = JSON.parse(cocktail_db_serialized)
cocktail_db['drinks'].each do |ingredient|
  Ingredient.create!(name: ingredient['strIngredient1'])
end

url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
cocktail_db_serialized = open(url).read
cocktail_db = JSON.parse(cocktail_db_serialized)
file = URI.open("https://www.thecocktaildb.com/images/media/drink/wpxpvu1439905379.jpg")
cocktail = Cocktail.new(name: cocktail_db['drinks'][0]['strDrink'])
cocktail.photo.attach(io: file, filename: "margarita.jpg", content_type: 'image/jpg')
cocktail.save

url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito"
cocktail_db_serialized = open(url).read
cocktail_db = JSON.parse(cocktail_db_serialized)
file = URI.open("https://www.thecocktaildb.com/images/media/drink/rxtqps1478251029.jpg")
cocktail = Cocktail.new(name: cocktail_db['drinks'][0]['strDrink'])
cocktail.photo.attach(io: file, filename: "mojito.jpg", content_type: 'image/jpg')
cocktail.save

100.times do
  url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
  # puts url
  cocktail_db_serialized = open(url).read
  # puts cocktail_db_serialized
  cocktail_db = JSON.parse(cocktail_db_serialized)
  # puts cocktail_db
  file = URI.open(cocktail_db['drinks'][0]['strDrinkThumb'])
  # puts file
  cocktail = Cocktail.new(name: cocktail_db['drinks'][0]['strDrink'])
  # puts cocktail
  cocktail.photo.attach(io: file, filename: "#{cocktail.name}.jpg", content_type: 'image/jpg')
  cocktail.save
=======
def ingredients_creation
  url = "www.thecocktaildb.com/api/json/v1/1/search.php?i=#{query}"
  JSON.parse(URI.parse(url).open.read)['drinks'].each do |ingredient|
    new_ingredient = Ingredient.new(name: ingredient['strIngredient'])
    new_ingredient.save!
  end
end

def cocktails_creation
  ('a'..'z').to_a.each do |letter|
    url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}"
    next if JSON.parse(URI.parse(url).open.read)['drinks'].nil?

    make_doses_and_cocktails(url)
  end
end

def make_doses_and_cocktails(url)
  JSON.parse(URI.parse(url).open.read)['drinks'].each do |c|
    doses_creation(c, create_cocktail(c))
  end
end

def create_cocktail(cocktail)
  new_cocktail = Cocktail.new(
    name: cocktail['strDrink'],
    instruction: cocktail['strInstructions'].gsub(/([\n|\r])/, '')
  )
  new_cocktail.photo.attach(
    io: URI.parse(cocktail['strDrinkThumb']).open,
    filename: cocktail['strDrinkThumb'][-15..-1]
  )
  new_cocktail.save if new_cocktail.valid?
  new_cocktail
end
