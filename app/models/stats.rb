class Stats
  def post_count
    Post.count
  end

  def tag_count
    Tag.count
  end
end
