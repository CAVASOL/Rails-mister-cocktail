class AddUserRefToCocktails < ActiveRecord::Migration[6.1]
  def change
    add_reference :cocktails, :user, foreign_key: true
  end
end
