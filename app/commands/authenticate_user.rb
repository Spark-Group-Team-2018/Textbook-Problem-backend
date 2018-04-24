# app/commands/authenticate_user.rb
# Credit: https://www.pluralsight.com/guides/token-based-authentication-with-ruby-on-rails-5-api?branch=linux-modder-ruby-ruby-on-rails-token-based-authentication-with-ruby-on-rails-5-api

# Library in charge of authenticating the user

class AuthenticateUser
  prepend SimpleCommand

  #Initialize with public user credentials
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Encodes the user id for auth token creation that is returned
  def call
    JsonWebToken::encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  #Authenticate the user based off credentials recieved
  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
