##
# 用户查找方法
#
#  User.by_email('123@qq.com')
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
    # 查找指定邮箱的用户, 支持二级缓存
    def by_email(email)
      self.fetch_by_uniq_keys(email: email)
    end

    ##
    # 查找指定用户名的用户, 支持二级缓存
    def by_uname(uname)
      self.fetch_by_uniq_keys(username: uname)
    end

  end
end