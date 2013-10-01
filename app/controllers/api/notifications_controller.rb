class Api::NotificationsController < ApiController
  before_filter :require_valid_username
  before_filter :require_limit
  before_filter :require_date

  def index
    user = User.find_by(username: params[:username])
    if params[:older_than].present?
      older_than = Time.parse(params[:older_than])
      render json: user.notifications.limit(params[:limit]).where('created_at < ?', older_than).order('created_at DESC')
    else
      since = Time.parse(params[:since])
      render json: user.notifications.limit(params[:limit]).where('created_at > ?', since).order('created_at DESC')
    end
  end
end
