class PostsController < ApplicationController

  def index
    access_token = Client.build_client current_user
    response = access_token.get("/posts")
    if response.code == "200"
      @posts = JSON.parse response.body
    else
      flash[:error] = "Server error [#{response.code}]: #{response.body}"
    end
  end

  def new
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
