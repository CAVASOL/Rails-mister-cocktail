# frozen_string_literal: true

# app/models/ingredient.rb
class Ingredient < ApplicationRecord
  has_many :doses
  has_many :cocktails, through: :doses
  has_many_attached :photos
  has_one :description

  validates :name, presence: true, uniqueness: true
end
