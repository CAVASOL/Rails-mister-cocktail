# frozen_string_literal: true

# app/controllers/cocktails_controller.rb
class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index explore]

  def index
    @cocktails = Cocktail.first(4)

    if params[:query].present?
      @query = params[:query]
      @cocktails = Cocktail.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @cocktails = Cocktail.first(4)
    end
  end

  def new
    @ingredients = Ingredient.all

    @cocktail = Cocktail.new
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.user = current_user
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def explore
    @cocktails = Cocktail.all

    if params[:query].present?
      @query = params[:query]
      @cocktails = Cocktail.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @cocktails = Cocktail.all
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @cocktails = Cocktail.all
    @dose = Dose.new
    @review = Review.new
    @reviews = Review.all
    @user = current_user
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    @cocktail.photo.attach(photo) if params[:cocktail][:photo].present?
    @cocktail.update(update_params)
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy
    redirect_to cocktails_path
  end

  def mypage
    # @my_cocktails = current_user.cocktails
    @my_ingredients = current_user.ingredients
    @my_review = current_user.reviews

    @favorited = current_user.all_favorited
  end

  private

  def cocktail_params
    params.require('cocktail').permit(:name, :instruction, :photo, :user_id)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
