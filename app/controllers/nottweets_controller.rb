class NottweetsController < ApplicationController
  include ActionView::Helpers::TextHelper
  MENTION_REGEX = /\@([\w\-]+)/
  HASHTAG_REGEX = /\#([\w\-]+)/

  def index
    @nottweets = timeline_nottweets.order('created_at DESC').page(params[:page]).per(50)
    @nottweet = Nottweet.new
  end

  def new
    @nottweet = Nottweet.new
  end

  def create
    @nottweet = Nottweet.new(nottweet_params)
    @nottweet.user = current_user
    @nottweet.content = strip_tags(@nottweet.content)

    find_mentions
    find_hashtags

    if @nottweet.save
      redirect_to root_url, notice: "Thanks for Borking!"
    else
      render "new"
    end
  end

  def hashtag
    if Rails.env.development?
      @hashtag = params[:hashtag]
      @search = Nottweet.search do
        keywords params[:hashtag]
      end
      @results = @search.results
    else
      @results = []
      flash[:alert] = "Unforntunately, searching only works in development"
    end
  end

  def destroy
    Nottweet.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def nottweet_params
    params.require(:nottweet).permit(:content, :attachment)
  end

  def timeline_nottweets
    user_ids = current_user.followed.map(&:id)
    Nottweet.where(user_id: user_ids)
  end

  def find_mentions
    @mentions = @nottweet.content.scan(MENTION_REGEX).flatten!
    unless @mentions.nil?
      @mentions.each do |mention|
        user = User.find_by(username: mention)
        @nottweet.content.sub!("@"+user.username, "<a href=\"/users/#{user.id.to_s}\">@#{user.username}</a>") if user
        Notification.create(user_id: user.id, content: "<a href=\"/users/#{current_user.id.to_s}\">#{current_user.username}</a> mentioned you in his bork \"#{@nottweet.content}\"")
      end
    end
  end
  def find_hashtags
    @hashtags = @nottweet.content.scan(HASHTAG_REGEX).flatten!
    unless @hashtags.nil?
      @hashtags.each do |hashtag|
        @nottweet.content.sub!("##{hashtag}", "<a href=\"/nottweets/search/#{hashtag}\">##{hashtag}</a>")
      end
    end
  end
end
