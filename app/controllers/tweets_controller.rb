require 'csv'

class TweetsController < ApplicationController
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
    
  end

  def download
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"user-list\""
        headers['Content-Type'] ||= Mime::CSV
      end
    end
  end

  def search
    
  end

end

#  # GET /tweets
#  # GET /tweets.json
#  def index
#    @tweets = Tweet.all
#  end
#
#  # GET /tweets/1
#  # GET /tweets/1.json
#  def show
#  end
#
#  # GET /tweets/new
#  def new
#    @tweet = Tweet.new
#  end
#
#  # GET /tweets/1/edit
#  def edit
#  end
#
#  # POST /tweets
#  # POST /tweets.json
#  def create
#    @tweet = Tweet.new(tweet_params)
#
#    respond_to do |format|
#      if @tweet.save
#        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
#        format.json { render :show, status: :created, location: @tweet }
#      else
#        format.html { render :new }
#        format.json { render json: @tweet.errors, status: :unprocessable_entity }
#      end
#    end
#  end
#
#  # PATCH/PUT /tweets/1
#  # PATCH/PUT /tweets/1.json
#  def update
#    respond_to do |format|
#      if @tweet.update(tweet_params)
#        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
#        format.json { render :show, status: :ok, location: @tweet }
#      else
#        format.html { render :edit }
#        format.json { render json: @tweet.errors, status: :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /tweets/1
#  # DELETE /tweets/1.json
#  def destroy
#    @tweet.destroy
#    respond_to do |format|
#      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
#      format.json { head :no_content }
#    end
#  end
#
#  private
#    # Use callbacks to share common setup or constraints between actions.
#    def set_tweet
#      @tweet = Tweet.find(params[:id])
#    end
#
#    # Never trust parameters from the scary internet, only allow the white list through.
#    def tweet_params
#      params.require(:tweet).permit(:username, :content)
#    end
#end