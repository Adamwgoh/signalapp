class UsersController < ApplicationController

before_action :get_client
def get_client
  $client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_OAUTH_TOKEN"]
    config.access_token_secret = ENV["TWITTER_OAUTH_TOKEN_SECRET"]
  end
end

def index
  username = 'adamwgoh'
  option = {:count => 3, :include_rts => true}
  @tweets = $client.search("airasia", result_type:'recent').take(3).collect()
end

def search
  username = params[:search]
  @users = $client.user_search(username)
end

def download
  id = params[:users] or params[:id]
  @followers = $client.followers(id.to_i)

  respond_to do |format|
    format.html
    format.csv do
      headers['Content-Disposition'] = "attachment; filename=\"user-list\""
      headers['Content-Type'] ||= Mime::CSV
    end
  end
end

def show
  id = params[:users]
  id ||= params[:id]

  @user = $client.user(id.to_i)
  @followers = $client.followers(id.to_i)
end

end
