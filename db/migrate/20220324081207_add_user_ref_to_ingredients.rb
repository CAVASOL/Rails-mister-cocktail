class AddUserRefToIngredients < ActiveRecord::Migration[6.1]
  def change
    add_reference :ingredients, :user, foreign_key: true
  end
end
