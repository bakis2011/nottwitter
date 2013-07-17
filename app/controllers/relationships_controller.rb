class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:id])
    current_user.follow(@user) if current_user
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user) if current_user
    respond_to do |format|
      format.js
    end
  end
end
