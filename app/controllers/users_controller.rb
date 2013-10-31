class UsersController < ApplicationController
  skip_before_action :authorize, only: [:index, :new, :create, :show, :authenticate]
  skip_before_filter :verify_authenticity_token, only: [:authenticate]
  AUTH_TOKEN = "wVdLktWLHkZZOxE4aEaPig"

  def index
    @users = User.order('created_at DESC')
  end

  def show
    @user = User.find(params[:id])
    @borks = Bork.where(user_id: @user.id).order('created_at DESC').page(params[:page]).per(50)
  end

  def favorites
    @borks = Favorite.where(user_id: params[:id]).map(&:bork).reject(&:blank?).order('created_at DESC')
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_url, notice: "I don't think so..."
    end
  end

  def update
    @user = User.find(params[:id])
    params[:user][:username].downcase!
    if params[:password][:changed] == "1"
      if @user.authenticate(params[:user][:old_password]) and @user.update_attributes(user_params)
        redirect_to user_path(@user.id), notice: "Password Updated"
      else
        flash[:alert] = "Invalid Password" if @user.errors.count.zero?
        render "edit"
      end
    else
      if @user.update_attributes(username: params[:user][:username], avatar: params[:user][:avatar])
        redirect_to user_path(@user.id), notice: "Profile Updated"
      else
        render "edit"
      end
    end
  end

  def destroy
    current_user.destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :avatar)
  end
end
