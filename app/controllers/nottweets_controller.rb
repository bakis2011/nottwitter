class NottweetsController < ApplicationController
  before_filter :authorize
  def index
    @nottweets = timeline_nottweets.order('created_at DESC')
    @nottweet = Nottweet.new
  end

  def new
    @nottweet = Nottweet.new
  end

  def create
    @nottweet = Nottweet.new(nottweet_params)
    @nottweet.user = current_user
    if @nottweet.save
      redirect_to root_url, notice: "Thanks for not tweeting"
    else
      render "new"
    end
  end

  private

  def nottweet_params
    params.require(:nottweet).permit(:content)
  end

  def timeline_nottweets
    user_ids = current_user.followed.map(&:id)
    Nottweet.where(user_id: user_ids)
  end
end
