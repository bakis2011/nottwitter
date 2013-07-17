class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "You are now logged in as #{user.username}"
    else
      render "new", alert: "Invalid username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You are now logged out"
  end

end
