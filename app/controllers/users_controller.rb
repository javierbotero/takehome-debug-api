class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :register
  skip_before_action :user_quota, only: :register
  skip_after_action :increment_monthly_hits, only: :register

  def index
    @users = User.all

    render json: @users
  end

  def show; end

  def path; end

  def register
    User.create!(email: params[:email])

    render json: { success: true, message: "#{params[:email]} registered" }, status: 200
  rescue StandardError => e
    render json: { error: e.message }, status: 400
  end
end
