class PagesController < ApplicationController
  def show
    @page = Page.find_by_slug(params[:id]) || raise(ActiveRecord::RecordNotFound)
    @sidebar = @page.sidebar.blank? ? nil : @page.sidebar
    @sidebar_style = @page.sidebar_class if @sidebar
  end
end
