class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token, :authorize
  before_filter :check_api_key

  def check_api_key
    render json: "invalid-api-key" unless params[:api_key] == API_KEY
  end

  %w{password token limit content}.each do |param|
    define_method "require_#{param}" do
      render json: "No #{param} given" unless params[param.to_sym].present?
    end
  end

  def require_valid_username
    render json: "Invalid username" unless params[:username].present? && User.find_by(username: params[:username]).present?
  end

  def require_valid_bork_id
    render json: "Invalid bork_id" unless params[:bork_id].present? && Bork.find(params[:bork_id]).present?
  end

  def require_date
    render json: "No time parameter given" unless params[:since].present? || params[:older_than].present?
  end

end
