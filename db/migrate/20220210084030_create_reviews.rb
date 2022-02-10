class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :author
      t.string :comment
      t.integer :rating
      t.references :cocktail, null: false, foreign_key: true

      t.timestamps
    end
  end
end
