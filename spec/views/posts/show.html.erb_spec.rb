require File.dirname(__FILE__) + '/../../spec_helper'

describe "/posts/show.html.erb" do
  include UrlHelper

  before(:each) do
    mock_tag = mock_model(Tag,
      :name => 'code'
    )

    @post = mock_model(Post,
      :title             => "A post",
      :body_html         => "Posts contents!",
      :published_at      => 1.year.ago,
      :slug              => 'a-post',
      :tags              => [mock_tag]
    )
    assigns[:post]    = @post
  end

  after(:each) do
    response.should be_valid_xhtml_fragment
  end

  it "should render a post" do
    render "/posts/show.html.haml"
  end
end
