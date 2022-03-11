class Cocktail < ApplicationRecord
  # acts_as_favoritable

  has_one_attached :photo

  has_many :doses, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ingredients, through: :doses

  validates :name, presence: true
  validates :photo, presence: true
  validates :instruction, presence: true
end
