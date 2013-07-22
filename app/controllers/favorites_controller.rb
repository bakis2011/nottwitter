class FavoritesController < ApplicationController
  def create
    @nottweet = Nottweet.find(params[:id])
    current_user.favorite(@nottweet)
    Notification.create(user_id: @nottweet.user.id, content: "#{current_user.username} favorited your tweet!")
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @nottweet = Nottweet.find(params[:id])
    current_user.unfavorite(@nottweet)
    respond_to do |format|
      format.js
    end
  end
end
