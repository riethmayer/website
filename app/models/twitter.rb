require 'httparty'
 
class Twitter
  include HTTParty
  base_uri 'twitter.com'
  
  def initialize
    @auth = { :username => APPS['twitter']['username'], :password => APPS['twitter']['password'] }
  end
  
  # which can be :friends, :user or :public
  # options[:query] can be things like since, since_id, count, etc.
  def timeline(which = :friends, options={})
    options.merge!({:basic_auth => @auth})
    self.class.get("/statuses/#{which}_timeline.json", options)
  end
  
  def post(text)
    options = { :query => {:status => text}, :basic_auth => @auth }
    self.class.post('/statuses/update.json', options)
  end
  
  def self.recent_user_tweets(n=3)
    t = Twitter.new
    t.timeline(:user, :query => { :count => n } )
  end
  
  def self.search(query)
    self.class.get("http://search.twitter.com/search.json?q=#{query}")
  end
end
 
# pp twitter.timeline(:friends, :query => {:since_id => 868482746})
# pp twitter.timeline(:friends, :query => 'since_id=868482746')
# pp twitter.post('this is a test of 0.2.0')