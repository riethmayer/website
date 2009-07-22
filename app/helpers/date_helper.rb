module DateHelper
  def format_month(date)
    date.strftime("%B %Y")
  end
  
  def format_post_date(date)
    date.strftime("%d.%B %Y")
  end
end
