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
      render json: true
    end
  end

  def destroy
    @bork = Bork.find(params[:bork_id])
    if owns_bork?
      @bork.destroy
      render json: true
    end
  end

  def undo_delete
    @bork = Bork.with_deleted.find(params[:bork_id])
    if owns_bork?
      @bork.deleted_at = nil
      render json: true
    end
  end

  def too_long?
    if params[:content].length > 160
      true
      render json: "Bork content too long"
    else
      false
    end
  end

  def owns_bork?
    if @bork.user.username == params[:username]
      true
    else
      false
      render json: "That's not your bork!"
    end
  end
end
