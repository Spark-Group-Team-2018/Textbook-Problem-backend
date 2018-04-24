# Controller that is tasked with api requests in regards to the user

class UsersController < ApplicationController

  # Apply user auth to all requests excluding read-db user requests and first-time user creation
  skip_before_action :authenticate_request, only: [:index, :show, :create]

  # Set the specific user that will be shown, updated, destroyed as requested by client
  before_action :set_user, only: [:show, :update, :destroy]


  # Return all users
  def index
    @users = User.all()
    render json: @users
  end

  # Return specific user as requested by client via user_id
  def show
    render json: @user
  end

  # Returns the client's user by getting the current_user variable + checking auth_token
  def getuser
    render json: @current_user
  end

  # Update the client's logged in user
  def updateuser

    if @current_user.update_attributes(user_params)
      render json: @current_user, status: :ok
    else
      render json: error_message
    end

  end

  # Registers new user for first time
  def create

    @new_user = User.new(user_params)

    if @new_user.save
      render json: @new_user
    else
      render json: {"status": "unable to save new user"}
    end

  end

  # NOT USED
  def update

  end

  # NO USERS NEED TO DELETE THEMSELVES YET
  def destroy

  end

  private

    # default error_message
    def error_message
      {"status": "unable to do specified action"}
    end

    # Set the current specified user for client related requests
    def set_user
      @user = User.find(params[:id])
    end

    # Retrieve the user fields as related to the user for user api requests
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
    end

end
