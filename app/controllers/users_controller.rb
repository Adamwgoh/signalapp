class UsersController < ApplicationController

before_action :get_client
def get_client
  $client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
  end
end

def index
  username = 'adamwgoh'
  option = {:count => 3, :include_rts => true}
  @tweets = $client.search("airasia", result_type:'recent').take(3).collect()
end

def search
  username = params[:keyword]
end

end
