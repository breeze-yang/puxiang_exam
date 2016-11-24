module ApplicationHelper

  # 定制标题的公共方法
  def full_title(page_title = '')
    base_title = "Breeze In"
    if page_title.empty?
      base_title
    else
      page_title + " · " + base_title
    end
  end

  def timeago(time, options = {})
    return '' if time.blank?
    options[:class] = options[:class].blank? ? 'timeago' : [options[:class], 'timeago'].join(' ')
    options[:title] = time.iso8601
    text = l time.to_date, format: :long
    content_tag(:abbr, text, options)
  end
end
