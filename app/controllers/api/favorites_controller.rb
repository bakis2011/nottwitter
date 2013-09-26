class Api::FavoritesController < ApiController
  before_filter :require_bork_id
  before_filter :require_valid_username

  def create
    @bork = Bork.find(params[:id])
    @user = User.find_by(username: params[:username])
    @user.favorite(@bork)
    Notification.create(author: @user, bork: @bork, user: @bork.user, action: "favorite")
  end

  def destroy
    @bork = Bork.find(params[:id])
    @user = User.find_by(username: params[:username])
    @user.unfavorite(@bork)
    Notification.find_by(author: @user, bork: @bork, user: @bork.user, action: "favorite").destroy
  end
end
