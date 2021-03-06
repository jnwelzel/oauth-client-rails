class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:inkdrop]

  def self.find_for_inkdrop_oauth(auth)
    u = where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.alias = auth.info.nickname
    end
    # This way the access token data will always be fresh
    u.token = auth.credentials.token
    u.secret = auth.credentials.secret
    u.save
    u
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.inkdrop_data"] && session["devise.inkdrop_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def access_token
    consumer_key = Rails.application.config.devise.omniauth_configs[:inkdrop].strategy.consumer_key
    OAuth::AccessToken.new consumer_key, self.token, self.secret
  end

end
