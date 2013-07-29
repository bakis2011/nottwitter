class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:id])
    current_user.follow(@user)
    Notification.create(author: current_user, user: @user, content: " followed you!")
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    Notification.find_by(author: current_user, user: @user, content: " followed you!").destroy
    respond_to do |format|
      format.js
    end
  end
end
