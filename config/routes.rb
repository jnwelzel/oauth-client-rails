OauthClient::Application.routes.draw do
  resources :posts
  get "omniauth_callbacks/inkdrop"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'logout', :to => 'devise/sessions#destroy', as: :user_logout
    get 'login', :to => 'devise/sessions#new', as: :user_login
  end

  get "home/index"
  root 'home#index'

end

