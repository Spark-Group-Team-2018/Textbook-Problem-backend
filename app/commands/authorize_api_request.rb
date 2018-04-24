# app/commands/authorize_api_request.rb

# Credit: https://www.pluralsight.com/guides/token-based-authentication-with-ruby-on-rails-5-api?branch=linux-modder-ruby-ruby-on-rails-token-based-authentication-with-ruby-on-rails-5-api
# Library in charge of authorizing api requests from the user

class AuthorizeApiRequest
  prepend SimpleCommand

  # Utility functions
  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  #if the decoded auth token user_id is actually an user then we know it is a authenticated api request
  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  # Decodes the auth token and retrieves the user id
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # Get the auth headers from api request
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add :token, 'Missing token'
    end
    nil
  end
end
