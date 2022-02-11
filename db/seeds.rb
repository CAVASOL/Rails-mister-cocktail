# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'
require 'yaml'

puts 'Cleaning up database...'
Cocktail.destroy_all
puts 'Database cleaned'

url = 'http://tmdb.lewagon.com/movie/top_rated'
movies = JSON.parse(open("#{url}?page=1").read)['results']
movies.each do |movie|
  puts "Creating #{movie['title']}"
  base_poster_url = 'https://image.tmdb.org/t/p/original'
  Movie.create(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
    rating: movie['vote_average']
  )
end
puts 'Movies created'


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

def doses_creation(cocktail, new_cocktail)
  (1..5).to_a.each do |number|
    next if cocktail["strMeasure#{number}"].nil? || Ingredient.find_by(
      name: cocktail["strIngredient#{number}"]
    ).nil?

    dose = Dose.new(description: cocktail["strMeasure#{number}"])
    ingredient = Ingredient.find_by(name: cocktail["strIngredient#{number}"])
    dose.cocktail = new_cocktail
    dose.ingredient = ingredient
    dose.save! if dose.valid?
  end
end

def seed_all
  ingredients_creation
  cocktails_creation
  doses_creation
end

# ('a'..'z').each do |letter|
#   url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}"
#   puts "getting #{letter}"
#   next if JSON.parse(open(url).read)['drinks'].nil?

#   cocktails = cocktail_repo['drinks'].sample(1)
#   cocktails.each do |cocktail|
#     new_cocktail = Cocktail.new(name: cocktail['strDrink'], instruction: cocktail['strInstruction'])
#     file = URI.open(cocktail['strDrinkThumb'])
#     new_cocktail.photo.attach(io: file, filename: "#{new_cocktail.name}.jpg", content_type: 'image/jpg')
#     new_cocktail.save
#   end
# end
