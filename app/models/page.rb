class Page < ActiveRecord::Base
  validates_presence_of :title, :slug, :body, :description

  before_validation     :generate_slug

  before_save           :apply_filter

  class << self
    def build_for_preview(params)
      page = Page.new(params)
      page.apply_filter
      page
    end
    
    def legal_sidebar_classes
      [ ["left:small"   , "yui-t1"],
        ["left:medium"  , "yui-t2"],
        ["left:large"   , "yui-t3"],
        ["right:small"  , "yui-t4"],
        ["right:medium" , "yui-t5"],
        ["right:large"  , "yui-t6"],
        ["none"         , "yui-t7"]  ]
    end
  end

  def apply_filter
    self.body_html = EnkiFormatter.format_as_xhtml(self.body)
  end

  def active?
    true
  end

  def destroy_with_undo
    transaction do
      self.destroy
      return DeletePageUndo.create_undo(self)
    end
  end

  def generate_slug
    self.slug = self.title.dup if self.slug.blank?
    self.slug.slugorize!
  end
end
