class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:inkdrop]

  def self.find_for_inkdrop_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.alias = auth.info.nickname
      user.token = auth.credentials.token
      user.secret = auth.credentials.secret
    end
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

end
