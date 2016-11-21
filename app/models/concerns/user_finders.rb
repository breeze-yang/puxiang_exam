##
# 用户查找方法
#
#  User.by_mobile('18620011234')
#
#  User.by_uname('hello')
#
#  先在二级缓存中尝试, 已存在数据, 则直接从缓存加载; 否则尝试从数据库查找
#  如果数据库中查到记录, 自动写入二级缓存并返回该数据
#  如果数据库中没有记录, 则返回 nil
module UserFinders
  extend ActiveSupport::Concern

  module ClassMethods
    ##
    # 查找指定user_id的用户, 支持二级缓存
    def by_user_id(user_id)
      self.fetch_by_uniq_keys(id: user_id)
    end

    ##
    # 查找指定手机号的用户, 支持二级缓存
    def by_mobile(mobile)
      self.fetch_by_uniq_keys(mobile: mobile)
    end

    ##
    # 查找指定用户名的用户, 支持二级缓存
    def by_uname(uname)
      self.fetch_by_uniq_keys(user_name: uname)
    end

  end
end