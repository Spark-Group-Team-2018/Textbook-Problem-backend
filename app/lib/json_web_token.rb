# Module for creation of JsonWebTokens
# Credit: https://www.pluralsight.com/guides/token-based-authentication-with-ruby-on-rails-5-api?branch=linux-modder-ruby-ruby-on-rails-token-based-authentication-with-ruby-on-rails-5-api
# Credit: https://github.com/jwt/ruby-jwt

module JsonWebToken
  # Encodes the user object into a token for auth. Expires after 24 hour
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  # Decodes token into its respective payload for authentciation
  def self.decode(token)
    body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new body
  rescue
    nil
  end
end
