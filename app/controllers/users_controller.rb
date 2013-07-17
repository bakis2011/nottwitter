class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thanks for signing up, #{@user.username}"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @following = Relationship.where(follower_id: @user.id)
    @followers = Relationship.where(followed_id: @user.id)
    @nottweets = Nottweet.where(user_id: @user.id)
  end

  def update
  end

  def destroy
    session[:user_id] = nil
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
