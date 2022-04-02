# frozen_string_literal: true

# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  def index
    @cocktail = Cocktail.find(params[:cocktail_id])
    @message = Message.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @message = Message.new(message_params)
    @message.cocktail = @cocktail
    @message.user = current_user
    if @message.save
      CocktailChannel.broadcast_to(
        @cocktail,
        render_to_string(partial: 'message', locals: { message: @message }))
      redirect_to cocktail_messages_path(@cocktail, anchor: "message-#{@message.id}")
    else
      render 'pages/inbox'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
