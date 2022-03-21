# frozen_string_literal: true

# app/controllers/ingredients_controller.rb
class IngredientsController < ApplicationController
  def new
    @ingredients = Ingredient.all
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredient = Ingredient.new

    if params[:query].present?
      @query = params[:query]
      @ingredients = Ingredient.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @ingredients = Ingredient.all
    end
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredient = Ingredient.new(ingredient_params)
    # @ingredient.cocktail = @cocktail
    if @ingredient.save
      redirect_to new_cocktail_dose_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
