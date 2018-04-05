class Api::BorksController < ApiController
  before_filter :require_valid_bork_id, only: [:destroy, :undo_delete]
  before_filter :require_valid_username, only: [:create, :destroy, :undo_delete]
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
      head :ok
    else
      render json: "Bork content too long", status: 422
    end
  end

  def destroy
    @bork = Bork.find(params[:bork_id])
    if owns_bork?
      @bork.destroy
      head :ok
    else
      render json: "That's not your bork!", status: 422
    end
  end

  def undo_delete
    @bork = Bork.with_deleted.find(params[:bork_id])
    if owns_bork?
      @bork.deleted_at = nil
      head :ok
    else
      render json: "That's not your bork!", status: 422
    end
  end

  def too_long?
    params[:content].length > 160
  end

  def owns_bork?
    @bork.user.username == params[:username]
  end

  def bork_favorites
    render json: Favorite.where(bork_id: params[:bork_id])
  end
end
