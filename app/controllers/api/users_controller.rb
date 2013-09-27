class Api::UsersController < ApiController
  before_filter :require_valid_username, except: [:index]
  before_filter :require_token, only: [:add_token]
  before_filter :require_password, only: [:authenticate]
  before_filter :require_limit, only: [:user_borks]

  def index
    render json: User.order('created_at DESC')
  end

  def authenticate
    @user = User.find_by(username: params[:username])
    if (@user.authenticate(params[:password]))
      render json: true
    else
      render json: "Invalid Password"
    end
  end

  def add_token
    @user = User.find_by(username: params[:username])
    if @token = Apns.find_by(token: params[:token])
      @token.user = @user
      render json: true
    else
      if @apns = Apns.create(user_id: @user.id, token: params[:token])
        render json: true
      else
        render json: @apns.errors
      end
    end
  end

  def favorites
    render json: User.find_by(username: params[:username]).favorites.map(&:id)
  end

  def user_borks
    render json: Bork.where(user_id: User.find_by(username: params[:username])).limit(params[:limit])
  end
end
