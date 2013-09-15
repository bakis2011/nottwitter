class NottweetsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @nottweets = Nottweet.all
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

    if @nottweet.save
      redirect_to root_url, notice: "Thanks for Borking!"
    else
      render "new"
    end
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
end
