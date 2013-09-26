class Api::NotificationsController < ApiController
  before_filter :require_valid_username
  before_filter :require_limit

  def index
    if valid_username_present? && limit_present?
      user = User.find_by(username: params[:username])
      render json: user.notifications.limit(params[:limit]).order('created_at DESC')
    end
  end
end
