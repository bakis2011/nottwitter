class Api::NotificationsController < ApiController
  def index
    user = User.find_by(username: params[:username])
    if params[:limit].present?
      render json: user.notifications.limit(params[:limit]).order('created_at DESC')
    else
      render json: "No bork limit given"
    end
  end
end
