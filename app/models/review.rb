# frozen_string_literal: true

# app/models/review.rb
class Review < ApplicationRecord
  RATINGS = (0..5).to_a

  belongs_to :cocktail
  belongs_to :user

  validates :author, presence: true
  validates :comment, presence: true
  validates :rating, presence: true, inclusion: { in: RATINGS }
end
