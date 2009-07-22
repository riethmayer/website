require File.dirname(__FILE__) + '/../../spec_helper'

describe "/layouts/login.html.haml" do
  it 'renders' do
    render '/layouts/login.html.haml'
  end
end
