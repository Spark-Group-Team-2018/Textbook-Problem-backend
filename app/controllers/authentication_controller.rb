# Controller in charge of handling authentication
# Credit: https://www.pluralsight.com/guides/token-based-authentication-with-ruby-on-rails-5-api?branch=linux-modder-ruby-ruby-on-rails-token-based-authentication-with-ruby-on-rails-5-api

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request #Does not need to authenticate itself

  def authenticate #Retrieve the api params of user_email and user_password for auth
    command = AuthenticateUser.call(params[:email], params[:password])

    # When it is successful in auth it returns the auth_token to the client
    # if not it tells the client that it is not authorized
    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
