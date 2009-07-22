# Comment is no association no more, it's an included service now.
require 'httparty'
class DisqusError < StandardError 
end

class Comment
  include HTTParty
  base_uri 'disqus.com'
  format :json
  default_params :forum_api_key => DISQUS_CONFIG['board']['api_key'], :user_api_key => DISQUS_CONFIG['my_api_key'], :api_version => "1.1"

  # Creates a new post on the thread. Does not check against spam filters or ban list.
  # This is intended to allow automated importing of comments.
  #
  # @param thread_id    the thread to post to
  # @param message      content of the post
  # @param author_name  post author
  # @param author_email post author email
  # @param created_at   defaults to current time UTC
  # @param parent_post  
  # @param author_url   authors homepage
  # @param forum_id     authors ip-address
  # @param user_api_key 
  def create_post(opts={})
    conf = DISQUS_CONFIG['board']
    raise_unless_succeeded self.class.post("/api/create_post", :query => { 
      :thread_id    => opts[:thread_id],
      :message      => opts[:message],
      :author_name  => opts[:author_name],
      :author_email => opts[:author_email],
      :created_at   => opts[:created_at], # %Y-%m-%dT%H:%M, current time is default,
      :parent_post  => opts[:parent_post],
      :author_url   => opts[:ip_address],
      :forum_id     => opts[:forum_id] || DISQUS_CONFIG['board']['id']
    })
  end

  # A list of objects representing all forums the user owns.
  def get_forum_list
    raise_unless_succeeded self.class.get("/api/get_forum_list")
  end

  # A string which is the Forum Key for the given forum. 
  def get_forum_api_key 
    raise_unless_succeeded self.class.get("/api/get_forum_api_key", :query => { 
      :forum_id  => DISQUS_CONFIG['board']['id']
    })
  end

  # list of objects representing all threads belonging to the given forum
  def get_thread_list
    raise_unless_succeeded self.class.get("/api/get_thread_list")
  end
  
  # An object mapping each thread_id to a list of two numbers. 
  # The first number is the number of visible comments on on the thread; 
  #    this would be useful for showing users of the site (e.g., "5 Comments"). 
  # The second number is the total number of comments on the thread. 
  #    These numbers are different because some forums require moderator approval, 
  #    some messages are flagged as spam, etc.
  def get_num_posts
    raise_unless_succeeded thread_ids = (get_thread_list)['message'].map {|e| e['id']}.join(',')
    self.class.get("/api/get_num_posts", :query => {
      :thread_ids    => thread_ids
    })
  end
  
  # A thread object if one was found, otherwise null. 
  # Only finds threads associated with the given forum.
  def get_thread_by_url(url)
    raise_unless_succeeded self.class.get("/api/get_thread_by_url", :query => {
      :url    => url
    })
  end
  
  # A list of objects representing all posts belonging to the given forum
  def get_thread_posts(thread_id)
    raise_unless_succeeded self.class.get("/api/get_thread_posts", :query => {
      :thread_id => thread_id
    })
  end
  
  # Create or retrieve a thread by an arbitrary identifying string of your choice. 
  # For example, you could use your local database's ID for the thread. This method
  #   allows you to decouple thread identifiers from the URLs on which they might 
  #   be appear. If no thread yet exists for the given identifier 
  #  (paired with the forum), one will be created.
  def thread_by_identifier(title, identifier)
    raise_unless_succeeded self.class.post("/api/thread_by_identifier", :query => {
      :title => title, 
      :identifier => identifier,
      :forum_api_key => DISQUS_CONFIG['board']['api_key']
    })
  end
  
  # small helper to help us figuring out what's up if something goes the shit
  def raise_unless_succeeded(answer)
    raise ArgumentError, "message and code must not be blank!" if answer['message'].blank? && answer['code'].blank?
    message   = answer['message']
    succeeded = answer['succeeded']
    code      = answer['code']
    raise DisqusError, "message: #{message}, code: #{code}" unless succeeded
    message
  end
end