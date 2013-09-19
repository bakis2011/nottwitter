class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token, :authorize
  API_KEY = "wVdLktWLHkZZOxE4aEaPig"
  before_filter :check_api_key

  def check_api_key
    render json: "invalid-api-key" unless params[:api_key] == API_KEY
  end
end
