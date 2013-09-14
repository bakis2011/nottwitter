class NottweetsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @nottweets = timeline_nottweets.order('created_at DESC').page(params[:page]).per(50)
    @nottweet = Nottweet.new
  end

  def new
    @nottweet = Nottweet.new
  end

  def jamesify
    text = params[:bork].downcase

    (text.length/75).round.times do
      text[rand(text.length)] = ('a'..'z').to_a.push('').sample
    end
    text[rand(text.length)] = ''
    text_array = text.downcase.split(' ')

    (text_array.length/1.5).round.times do
      text_array.sample.squeeze!
    end

    (text_array.length/4).round.times do
      text_array.sample.capitalize!
    end

    @james_bork = text_array.join(' ')
  end

  def create
    @nottweet = Nottweet.new(nottweet_params)
    @nottweet.user = current_user
    @nottweet.content = strip_tags(@nottweet.content)

    # find_mentions
    # find_hashtags

    if @nottweet.save
      redirect_to root_url, notice: "Thanks for Borking!"
    else
      render "new"
    end
  end

  def refresh
  end

  def show
    @nottweet = Nottweet.find(params[:id])
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
    Nottweet.where(user_id: current_user.followed_ids)
  end

  # def find_mentions
  #   @nottweet.content.gsub!(MENTION_REGEX) do |match|
  #     user_match = match[1..-1]
  #     user = User.find_by(username: user_match)
  #     Notification.create(author: current_user, user: user, nottweet: @nottweet, action: "mention")
  #     "<a href=\"/users/#{user.id.to_s}\">#{match}</a>"
  #   end
  # end
  # def find_hashtags
  #   @nottweet.content.gsub!(HASHTAG_REGEX) do |match|
  #     "<a href=\"/nottweets/search/#{match[1..-1]}\">#{match}</a>"
  #   end
  # end
end
