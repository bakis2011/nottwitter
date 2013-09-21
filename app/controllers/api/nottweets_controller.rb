class Api::NottweetsController < ApiController
  def index
    if params[:limit].present?
      if params[:older_than].present?
        older_than = Time.parse(params[:older_than])
        render json: Nottweet.all.limit(params[:limit]).where('created_at < ?', older_than).order('created_at DESC')
      elsif params[:since].present?
        since = Time.parse(params[:since])
        binding.pry
        render json: Nottweet.all.limit(params[:limit]).where('created_at > ?', since).order('created_at DESC')
      else
        render json: "No time parameter given"
      end
    else
      render json: "No bork limit given" unless params[:limit].present?
    end
  end

  def create
    if params[:content].present? && params[:username].present?
      if params[:content].length > 160
        render json: "Bork content too long"
      else
        Nottweet.create(content: params[:content], user_id: User.find_by(username: params[:username]).id)
        render json: true
      end
    else
      render json: false
    end
  end
end
