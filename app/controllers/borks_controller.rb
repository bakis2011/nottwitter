class BorksController < ApplicationController
  include ActionView::Helpers::TextHelper
  skip_before_filter :authorize, only: [:borks_for_app, :random]

  def index
    @borks = Bork.all.order('created_at DESC').page(params[:page]).per(50)
    @bork = Bork.new
  end

  def random
    @bork = Bork.order("RANDOM()").first
  end

  def new
    @bork = Bork.new
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
    @bork = Bork.new(bork_params)
    @bork.user = current_user
    @bork.content = strip_tags(@bork.content)

    if @bork.save
      redirect_to root_url, notice: "Thanks for Borking!"
    else
      render "new"
    end
  end


  def show
    @bork = Bork.find(params[:id])
  end

  def destroy
    Bork.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def bork_params
    params.require(:bork).permit(:content, :attachment)
  end
end
