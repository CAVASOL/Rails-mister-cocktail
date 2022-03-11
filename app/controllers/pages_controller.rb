# frozen_string_literal: true

# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def mypage
    @favourited = current_user.all_favorited
  end

  def profile
    @user = current_user
  end
end
