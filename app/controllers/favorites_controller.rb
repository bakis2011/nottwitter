class FavoritesController < ApplicationController
  def create
    @bork = Bork.find(params[:id])
    current_user.favorite(@bork)
    Notification.create(author: current_user, bork: @bork, user: @bork.user, action: "favorite")
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @bork = Bork.find(params[:id])
    current_user.unfavorite(@bork)
    Notification.find_by(author: current_user, bork: @bork, user: @bork.user, action: "favorite").destroy
    respond_to do |format|
      format.js
    end
  end
end
