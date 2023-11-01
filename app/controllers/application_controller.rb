class ApplicationController < ActionController::API
  before_action :authenticate_user!
  before_action :user_quota
  after_action :increment_monthly_hits

  private

  def user_quota
    render json: { error: 'over quota' } if current_user.count_hits >= 10000
  end

  def authenticate_user!
    begin
      current_user
    rescue => e
      render json: { error: 'invalid email' }, status: 401
    end
  end

  def current_user
    @current_user ||= User.find_by!(email: params[:email])
  end

  def increment_monthly_hits
    current_user.hits.create!(endpoint: request.path)
  end
end
