class Api::UsersController < ApiController

  def index
    render json: User.order('created_at DESC')
  end

  def authenticate
    @user = User.find_by(username: params[:username])
    if (@user && @user.authenticate(params[:password]))
      render json: true
    else
      render json: "Invalid Username or Password"
    end
  end
end
