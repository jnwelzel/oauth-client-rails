class Client
  SITE = "http://localhost:8080/rest"

  # Build access token that's used for the actual "real" web service calls that you perform against the server
  def self.build_client(user)
    consumer_key = Rails.application.config.devise.omniauth_configs[:inkdrop].strategy.consumer_key
    consumer_secret = Rails.application.config.devise.omniauth_configs[:inkdrop].strategy.consumer_secret
    consumer = OAuth::Consumer.new consumer_key, consumer_secret, {site: SITE}
    OAuth::AccessToken.new consumer, user.token, user.secret
  end
end
