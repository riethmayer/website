require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/dashboard/show.html.erb" do
  after(:each) do
    response.should be_valid_xhtml_fragment
  end

  it 'should render' do
    assigns[:posts] = [mock_model(Post, 
      :title             => 'A Post',
      :published_at      => Time.now,
      :slug              => 'a-post'
    )]
    assigns[:stats] = Struct.new(:post_count, :tag_count).new(3,1)
    render '/admin/dashboard/show.html.erb'
  end
end
