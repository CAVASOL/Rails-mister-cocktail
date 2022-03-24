# frozen_string_literal: true

# app/controllers/ingredients_controller.rb
class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
    @ingredient = Ingredient.new

    if params[:query].present?
      @query = params[:query]
      @ingredients = Ingredient.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @ingredients = Ingredient.all
    end
  end

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredients = Ingredient.all
    @ingredient = Ingredient.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredient = Ingredient.new(ingredient_params)
    # @ingredient.cocktail = @cocktail
    # @ingredient.user = current_user
    if @ingredient.save
      redirect_to new_cocktail_dose_path(@cocktail.id)
    else
      render :new
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to request.referer
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :cocktail_id, :user_id)
  end
end
