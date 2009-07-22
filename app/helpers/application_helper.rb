# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def author
    Struct.new(:name, :email).new(config[:author][:name], config[:author][:email])
  end

  def open_id_delegation_link_tags(server, delegate)
    links = <<-EOS
      <link rel="openid.server" href="#{server}" />
      <link rel="openid.delegate" href="#{delegate}" />
    EOS
  end
    
  def cc_license
    "(cc) http://creativecommons.org/licenses/by/3.0/de/legalcode"
  end
  
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, html_escape(flash[msg.to_sym]), 
                        :id => "flash_#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end
  
  def twittered_about
    tweets = ""
    Twitter.recent_user_tweets.each do |t|
      tweet = t["user"]
      bild   = link_to(image_tag(tweet['profile_image_url'], :height => '50px', :width => '50px'), "http://twitter.com/#{tweet['screen_name']}", :class => 'image tweet-image')
      user_link = link_to( "@#{tweet['screen_name']}", "http://twitter.com/#{tweet['screen_name']}" )
      inhalt = "<p class='tweet'>#{bild} &bdquo;#{t['text']}&rdquo; von  #{user_link}</p>\n"
      tweets += inhalt
    end
    @tweets = tweets
  end
  
  def yui_style
    { :id     => (@document_style || YUI_CONFIG['width']) , 
      :class  => (@sidebar_style  || YUI_CONFIG['sidebar'] )}
  end
end
