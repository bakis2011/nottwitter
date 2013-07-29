class FavoritesController < ApplicationController
  def create
    @nottweet = Nottweet.find(params[:id])
    current_user.favorite(@nottweet)
    Notification.create(author: current_user, user: @nottweet.user, content: " favorited your bork!")
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @nottweet = Nottweet.find(params[:id])
    current_user.unfavorite(@nottweet)
    Notification.find_by(author: current_user, user: @nottweet.user, content: " favorited your bork!").destroy
    respond_to do |format|
      format.js
    end
  end
end
