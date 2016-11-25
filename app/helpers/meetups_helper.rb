module MeetupsHelper

  ##
  # 收藏功能
  # 后续收藏模块往这里完善
  def favorite_tag
    title = '收藏'
    icon = content_tag('i', '', class: "glyphicon glyphicon-bookmark")
    link_to(raw("#{icon} 收藏"), '#', title: title)
  end

end
