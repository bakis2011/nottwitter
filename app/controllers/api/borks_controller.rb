class Api::BorksController < ApiController
  before_filter :require_valid_bork_id, only: [:delete]
  before_filter :require_valid_username, only: [:create, :delete]
  before_filter :require_limit, only: [:index]
  before_filter :require_content, only: [:create]
  before_filter :require_date, only: [:index]

  def index
    if params[:older_than].present?
      older_than = Time.parse(params[:older_than])
      render json: Bork.all.limit(params[:limit]).where('created_at < ?', older_than).order('created_at DESC')
    else
      since = Time.parse(params[:since])
      render json: Bork.all.limit(params[:limit]).where('created_at > ?', since).order('created_at DESC')
    end
  end

  def create
    unless too_long?
      Bork.create(content: params[:content], user_id: User.find_by(username: params[:username]).id)
      render json: true
    end
  end

  def delete
    @bork = Bork.find(params[:id])
    @bork.destroy if @bork.username == params[:username]
  end

  def too_long?
    if params[:content].length > 160
      render json: "Bork content too long"
      true
    else
      false
    end
  end
end
