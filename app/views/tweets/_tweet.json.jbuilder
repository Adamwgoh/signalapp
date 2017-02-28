json.extract! tweet, :id, :username, :content, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)