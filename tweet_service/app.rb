require 'sinatra'
require 'sequel'
require 'json'
require 'sinatra/cross_origin'

dbloc = ENV['database'] || 'sqlite://dev.db'

db = Sequel.connect(dbloc)
tweets = db.from(:tweets)

configure do
  enable :cross_origin
end

options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,DELETE,OPTIONS"
  
  # Needed for AngularJS
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  
  200
end

post '/tweet' do					#if post at /tweet
	tweet = JSON.parse request.body.read		#receives tweet
	tweet['created_at'] = Time.now			#adds timestamp
	begin
		tweets.insert(tweet)			#inserts tweet
		200					#good response
	rescue
		400					#malformed
	end
end

get '/all' do						#gets all tweets
	"#{tweets.all()}"
end

post '/get_tweets_for' do						#if post at /read
	req = JSON.parse request.body.read		#receives tweet
	users = req['users'] 
	puts req['users']
	begin
		tweets.where([[:user, users]]).all()
	rescue
		400					#malformed
	end
end

