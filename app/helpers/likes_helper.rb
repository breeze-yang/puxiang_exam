module LikesHelper
  ##
  # 赞功能
  # 后续点赞模块往这里完善
  def likeable_tag
    label = '0个赞'
    title = '赞'
    icon = content_tag('i', '', class: "glyphicon glyphicon-heart")
    like_label = raw "#{icon} <span>#{label}</span>"
    link_to(like_label, '#', title: title)
  end

end
