class UsersController < ApplicationController
  def index; end

  def show; end

  def path; end

  def register
    User.create!(params[:email])

    render json: { success: true, message: params[:email] + ' registered' }, status: 200
  rescue StandardError => e
    render json: { error: e.message }, status: 400
  end
end
