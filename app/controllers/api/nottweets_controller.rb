class Api::NottweetsController < ApiController
  def index
    if params[:limit].present?
      if params[:older_than].present?
        older_than = Time.parse(params[:older_than])
        render json: Nottweet.all.limit(params[:limit]).where('created_at < ?', older_than).order('created_at DESC')
      elsif params[:since].present?
        since = Time.parse(params[:since])
        render json: Nottweet.all.limit(params[:limit]).where('created_at > ?', since).order('created_at DESC')
      else
        render json: "No time parameter given"
      end
    else
      render json: "No bork limit given" unless params[:limit].present?
    end
  end
end
