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

  # def add_token
  #   @user = User.find_by(username: params[:username])
  #   if @token = Apns.find_by(token: params[:token])
  #     @token.user = @user
  #   else
  #     Apns.create(user_id: @user.id, token: params[:token])
  #   end
  #   APNS.send_notification(params[:token], :alert => 'Hello iPhone!', :sound => 'default')
  # end
end
