# frozen_string_literal: true

# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @review = Review.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @review = Review.new(review_params)
    @review.cocktail = @cocktail
    @user = current_user
    if @review.save
      redirect_to new_cocktail_review_path(@cockatil)
    else
      @review = Review.new
      render 'cocktails/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to cocktail_path(@review.cocktail)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :author, :user_id, :cocktail_id)
  end
end
