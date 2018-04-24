#Root code lib that the rest of controllers inherit

class ApplicationController < ActionController::API

  # Authenticates all model controller requests
  before_action :authenticate_request

  attr_reader :current_user
     # helper_method :current_user

  private

    # Authenticates the api request and declares current_user variable to be used with corresponding model controllers
    def authenticate_request
       @current_user = AuthorizeApiRequest.call(request.headers).result

       render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end

end
