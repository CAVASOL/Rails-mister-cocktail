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

5.times do |i|
  User.new(
    name: Faker::Name.name,
    email: "user_#{i + 1}@email.com",
    password: '123456'
  ).save!
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

cocktail_2 = Cocktail.new(
  name: 'Negroni',
  instruction: 'Add the gin, Campari and sweet vermouth to a mixing glass filled
                with ice, and stir until well-chilled. Strain into a rocks glass
                filled with large ice cubes. Garnish with an orange peel.'
)

pic_2 = URI.open('https://www.liquor.com/thmb/JxTOAr3j6QredEyM1IzcohLDZ80=/720x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__05__08110806__negroni-720x720-recipe-7c1b747a616f4659af4008d025ab55df.jpg')
cocktail_2.photo.attach(io: pic_2, filename: 'Negroni.jpg', content_type: 'image/jpg')
cocktail_2.save!

cocktail_3 = Cocktail.new(
  name: 'Boiler Room',
  instruction: 'Add the bourbon, ginger liqueur, marigold tea, lemon juice and
                honey syrup into a pint glass filled with ice and stir to combine.
                Top with the beer and stir again gently and briefly to combine.
                Garnish with a long lemon twist.'
)

pic_3 = URI.open('https://www.liquor.com/thmb/Imhec3rSwSFeXkTFR1DXsBVNEvg=/720x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/boiler-room-720x720-primary-63f1118775b94ee3a397adcb4a79baa3.jpg')
cocktail_3.photo.attach(io: pic_3, filename: 'Boiler-room.jpg', content_type: 'image/jpg')
cocktail_3.save!

cocktail_4 = Cocktail.new(
  name: 'Bourbon Rosemary Punch',
  instruction: 'Combine the rosemary-infused Aperol, bourbon, honey syrup and
                grapefruit juice in a punch bowl and add large ice cubes. For
                each serving, ladle 3 ounces of punch into a punch glass filled
                with ice cubes. Top with a splash of sparkling wine and a
                splash of soda water. Garnish with a grapefruit wheel and a
                rosemary sprig.'
)

pic_4 = URI.open('https://www.liquor.com/thmb/ULqlgHv_y76cLjwl8I87dc8m3VI=/720x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__11__02092246__Bourbon-Rosemary-Punch-720x720-article-edb8d0ac38c443e992980a44da8595c7.jpg')
cocktail_4.photo.attach(io: pic_4, filename: 'Bourbon-rosemary.jpg', content_type: 'image/jpg')
cocktail_4.save!

cocktail_5 = Cocktail.new(
  name: 'Bourbon Strawberry Iced Tea',
  instruction: 'Add the strawberries and lemon juice into a shaker and gently muddle.
                Add the bourbon and simple syrup, add ice, and shake until well-chilled.
                Strain into a Collins glass over fresh ice. Top with unsweetened iced tea.
                Garnish with skewered blueberries and strawberries and a mint sprig.'
)

pic_5 = URI.open('https://www.liquor.com/thmb/7j9XEFuyCpgFK7qI29s37xmjhYw=/720x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__06__04100618__bourbon-strawberry-iced-tea-720x720-article-6163c34005fd4c13bfaba53ad19d6508.jpg')
cocktail_5.photo.attach(io: pic_5, filename: 'Iced-tea.jpg', content_type: 'image/jpg')
cocktail_5.save!

cocktail_6 = Cocktail.new(
  name: 'Bordeaux Sour',
  instruction: 'In a shaker, muddle the cherry and maple syrup. Add the bourbon,
                red wine, lemon juice and orange bitters with ice, and shake until
                well-chilled. Double-strain into a rocks glass over fresh ice.
                Garnish with a maraschino cherry.'
)

pic_6 = URI.open('https://www.liquor.com/thmb/7XwmNjvQVwSC91eBZAASnc--BII=/720x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/boudreaux-sour-720x720-primary-a40f160e21fe4171b86a9c41a9e62a75.jpg')
cocktail_6.photo.attach(io: pic_6, filename: 'Bordeaux-sour.jpg', content_type: 'image/jpg')
cocktail_6.save!

cocktail_7 = Cocktail.new(
  name: 'Manhattan',
  instruction: 'Add the bourbon (or rye), sweet vermouth and both bitters to a
                mixing glass with ice, and stir until well-chilled. Strain into
                a chilled coupe. Garnish with a brandied cherry or a lemon twist.'
)

pic_7 = URI.open('https://www.liquor.com/thmb/juGAUFgLo8gEc_ri0dRVzNwS8ic=/720x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__05__10144903__Manhattan-720x720-recipe-9497922907c14d91898f557cb51f2ea3.jpg')
cocktail_7.photo.attach(io: pic_7, filename: 'Manhattan.jpg', content_type: 'image/jpg')
cocktail_7.save!

cocktail_8 = Cocktail.new(
  name: 'Millionaire',
  instruction: 'Add the bourbon, Grand Marnier, absinthe, grenadine, egg white
                and lemon juice into a shaker and dry-shake (without ice) vigorously.
                Add ice and shake again until well-chilled. Double-strain into a
                chilled coupe glass. Grate nutmeg over the top of the drink.'
)

pic_8 = URI.open('https://www.liquor.com/thmb/Nh3ehdtL3G-IjP2dHCj5yalG6zw=/720x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2019__10__15112904__millionaire-720x720-recipe-6959113ea8e045fe974e29b50b933440.jpg')
cocktail_8.photo.attach(io: pic_8, filename: 'Millionaire.jpg', content_type: 'image/jpg')
cocktail_8.save!
