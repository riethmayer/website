module UrlHelper
  def posts_path(options = {})
    if options[:tag]
      options[:tag] = options[:tag].name if options[:tag].respond_to?(:name)
      options[:tag] = options[:tag].downcase
      posts_with_tag_path(options)
    else
      super
    end
  end

  def formatted_posts_path(options = {})
    if options[:tag]
      options[:tag] = options[:tag].name if options[:tag].respond_to?(:name)
      options[:tag] = options[:tag].downcase
      formatted_posts_with_tag_path(options)
    else
      posts_path(options)
    end
  end

  def post_path(post, options = {})
    suffix = options[:anchor] ? "##{options[:anchor]}" : ""
    path = post.published_at.strftime("/%Y/%m/%d/") + post.slug + suffix
    path = URI.join(config[:url], path) if options[:only_path] == false
    path.untaint
  end

  def page_path(page)
    return "/pages/#{page.slug}" if page.is_a? Page
    "#{page.url}"
  end

  def posts_atom_path(tag)
    if tag.blank?
      formatted_posts_path(:format => 'atom')
    else
      formatted_posts_with_tag_path(:tag => tag, :format => 'atom')
    end
  end
end
