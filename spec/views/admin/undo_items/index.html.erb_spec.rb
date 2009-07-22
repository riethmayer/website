require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/undo_items/index.html.erb" do
  after(:each) do
    response.should be_valid_xhtml_fragment
  end

  it 'should render' do
    assigns[:undo_items] = [mock_model(UndoItem,
      :description => 'You did something evil',
      :created_at  => Time.now
    )]
    render '/admin/undo_items/index.html.erb'
  end
end
