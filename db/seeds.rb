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

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
cocktail_db_serialized = open(url).read
cocktail_db = JSON.parse(cocktail_db_serialized)
cocktail_db['drinks'].each do |ingredient|
  Ingredient.create!(name: ingredient['strIngredient1'])
end

url = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita'
cocktail_db_serialized = open(url).read
cocktail_db = JSON.parse(cocktail_db_serialized)
file = URI.open('https://www.thecocktaildb.com/images/media/drink/wpxpvu1439905379.jpg')
cocktail = Cocktail.new(name: cocktail_db['drinks'][0]['strDrink'])
cocktail.photo.attach(io: file, filename: 'margarita.jpg', content_type: 'image/jpg')
cocktail.save

url = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito'
cocktail_db_serialized = open(url).read
cocktail_db = JSON.parse(cocktail_db_serialized)
file = URI.open('https://www.thecocktaildb.com/images/media/drink/rxtqps1478251029.jpg')
cocktail = Cocktail.new(name: cocktail_db['drinks'][0]['strDrink'])
cocktail.photo.attach(io: file, filename: 'mojito.jpg', content_type: 'image/jpg')
cocktail.save

100.times do
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
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
end

cocktail_1 = Cocktail.new(
  name: 'Old fashioned',
  instruction: 'Add the sugar and bitters to a rocks glass, then add the water,
                and stir until the sugar is nearly dissolved. Fill the glass
                with large ice cubes, add the bourbon, and gently stir to combine.
                Express the oil of an orange peel over the glass, then drop in.'
)

pic_1 = URI.open('https://www.liquor.com/thmb/_0WLXSRV03SfpWgZ1hwiAkyIrzE=/720x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__05__08113350__bourbon-old-fashioned-720x720-recipe-ade6f7780c304999be3577e565c9bcdd.jpg')
cocktail_1.photo.attach(io: pic_1, filename: 'Old-fashioned.jpg', content_type: 'image/jpg')
cocktail_1.save!
