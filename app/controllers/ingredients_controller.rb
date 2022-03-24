# frozen_string_literal: true

# app/controllers/ingredients_controller.rb
class IngredientsController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredient = Ingredient.new

    @ingredients = Ingredient.all
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
    @ingredient.cocktail = @cocktail
    # @cocktail.user = current_user
    if @ingredient.save
      redirect_to new_cocktail_dose_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to new_cocktail_ingredient_path
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :ingredient_id)
  end
end
