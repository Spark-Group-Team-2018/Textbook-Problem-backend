class UsersController < ApplicationController

  skip_before_action :authenticate_request, only: [:index, :show, :create]
  before_action :set_user, only: [:show, :update, :destroy]



  def index
    @users = User.all()
    render json: @users
  end

  def show
    render json: @user
  end

  def getuser
    render json: @current_user
  end

  ## TODO Add ability to register new user
  def create

    @new_user = User.new(user_params)

    if @new_user.save
      render json: @new_user
    else
      render json: {"status": "unable to save new user"}
    end

  end

  def update

  end

  def destroy

  end

  private

    def error_message
      {"status": "unable to do specified action"}
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
    end

end
