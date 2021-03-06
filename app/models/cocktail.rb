# frozen_string_literal: true

# app/models/cocktail.rb
class Cocktail < ApplicationRecord
  acts_as_favoritable

  belongs_to :user

  has_one_attached :photo
  has_many :doses, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ingredients, through: :doses
  # has_many :favorites, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :photo, presence: true
  validates :instruction, presence: true
end
