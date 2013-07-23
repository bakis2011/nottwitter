class FavoritesController < ApplicationController
  def create
    @nottweet = Nottweet.find(params[:id])
    current_user.favorite(@nottweet)
    Notification.create(user_id: @nottweet.user.id, content: "<a href=\"/users/#{current_user.id.to_s}\">#{current_user.username}</a> favorited your bork!")
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
