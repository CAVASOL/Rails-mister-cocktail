# frozen_string_literal: true

# app/controllers/cocktails_controller.rb
class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index explore show]

  def index
    @ingredients = Ingredient.all
    @cockatils = Cocktail.all

    if params[:query].present?
      @query = params[:query]
      @cocktails = Cocktail.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @cocktails = Cocktail.all.first(4)
    end
  end

  def explore
    @cockatils = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @ingredients = Ingredient.all

    @cocktail = Cocktail.new
    @dose = Dose.new
  end

  def create
    @cocktails = Cocktail.all
    @cocktail = Cocktail.new(cocktail_params)
    @cockatil.user = current_user
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    if params[:cocktail][:photo].present?
      @cocktail.photo.attach(photo)
    end
    @cocktail.update(update_params)
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @cocktail = Cocktail.find(params)
    @cocktail.desctroy
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    params.require('cocktail').permit(:name, :instruction, :photo)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
