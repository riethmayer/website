require File.dirname(__FILE__) + '/../../spec_helper'

describe "/archives/index.html.haml" do
  def tag(name)
    mock_model(Tag, :name => name)
  end

  before(:each) do
    month = Struct.new(:date, :posts)
    assigns[:months] = [
      month.new(1.month.ago.utc.beginning_of_month, [
        mock_model(Post, :title => 'Post A', :published_at => 3.weeks.ago.utc, :slug => 'post-a', :tags => [tag("Code")])
      ]),
      month.new(2.months.ago.utc.beginning_of_month, [
        mock_model(Post, :title => 'Post B', :published_at => 6.weeks.ago.utc, :slug => 'post-b', :tags => [tag("Code"), tag("Ruby")]),
        mock_model(Post, :title => 'Post C', :published_at => 7.weeks.ago.utc, :slug => 'post-c', :tags => [])
      ])
    ]
  end

  after(:each) do
    response.should be_valid_xhtml_fragment
  end

  it 'renders posts grouped by month' do
    render "/archives/index.html.haml"
  end
end
