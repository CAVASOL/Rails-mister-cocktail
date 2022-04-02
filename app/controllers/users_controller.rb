# frozen_string_literal: true

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def profile; end

  def inbox
    @cocktails = Cocktail.all
    @my_cocktails = current_user.cocktails
  end
end
