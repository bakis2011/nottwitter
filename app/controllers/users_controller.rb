class UsersController < ApplicationController
  skip_before_action :authorize, only: [:index, :new, :create, :show]

  def index
    @users = User.order('created_at DESC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Relationship.create(followed_id: @user.id, follower_id: @user.id)
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
    @nottweets = Nottweet.where(user_id: @user.id).order('created_at DESC')
  end

  def following
    @following = Relationship.where(follower_id: params[:id]).map(&:followed).order('created_at DESC')
  end

  def followers
    @followers = Relationship.where(followed_id: params[:id]).map(&:follower).order('created_at DESC')
  end

  def favorites
    @nottweets = Favorite.where(user_id: params[:id]).map(&:nottweet).reject(&:blank?).order('created_at DESC')
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_url, notice: "I don't think so..."
    end
  end

  def update
    @user = User.find(params[:id])
    if params[:password][:changed] == "1"
      if @user.authenticate(params[:user][:old_password]) and @user.update_attributes(user_params)
        redirect_to user_path(@user.id), notice: "Password Updated"
      else
        flash[:alert] = "Invalid Password" if @user.errors.count.zero?
        render "edit"
      end
    else
      if @user.update_attributes(username: params[:user][:username], email: params[:user][:email], avatar: params[:user][:avatar])
        redirect_to user_path(@user.id), notice: "Profile Updated"
      else
        render "edit"
      end
    end
  end

  def destroy
    session[:user_id] = nil
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
  end
end
