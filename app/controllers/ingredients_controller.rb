# frozen_string_literal: true

# app/controllers/ingredients_controller.rb
class IngredientsController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.cocktail = @cocktail
    if @ingredient.save
      redirect_to cocktail_path(@cocktail)
    else
      @dose = Dose.new
      render 'cocktails/show'
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
