class NottweetsController < ApplicationController
  include ActionView::Helpers::TextHelper
  skip_before_filter :authorize, only: [:borks_for_app]

  def index
    @nottweets = Nottweet.all.order('created_at DESC').page(params[:page]).per(50)
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

  def destroy
    Nottweet.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def nottweet_params
    params.require(:nottweet).permit(:content, :attachment)
  end
end
