class UsersController < ApplicationController

  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all()
    render json: @users
  end

  def show
    render json: @user
  end

  ## TODO Add ability to register new user
  def create

  end

  def update

  end

  def destroy

  end

  private

    def set_user
      @user = User.find(params[:id])
    end

end
