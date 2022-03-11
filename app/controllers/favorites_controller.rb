# frozen_string_literal: true

# app/controllers/favorites_controller.rb
class FavoritesController < ApplicationController
  def create
    @cockatil = Cocktail.find(params[:cockatil_id])

    current_user.favorite(@cockatil)
    redirect_to request.referer
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])

    current_user.unfavorite(@cocktail)
    redirect_to request.referer
  end
end
