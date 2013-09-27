class Api::FavoritesController < ApiController
  before_filter :require_valid_bork_id
  before_filter :require_valid_username

  def create
    @bork = Bork.find(params[:bork_id])
    @user = User.find_by(username: params[:username])
    @user.favorite(@bork)
    Notification.create(author: @user, bork: @bork, user: @bork.user, action: "favorite")
    render json: true
  end

  def favorited
    @bork = Bork.find(params[:bork_id])
    @user = User.find_by(username: params[:username])
    render json: @user.favorited?(@bork)
  end

  def destroy
    @bork = Bork.find(params[:bork_id])
    @user = User.find_by(username: params[:username])
    @user.unfavorite(@bork)
    Notification.find_by(author: @user, bork: @bork, user: @bork.user, action: "favorite").destroy
    render json: true
  end
end
