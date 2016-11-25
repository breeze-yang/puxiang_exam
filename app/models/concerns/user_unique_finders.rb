##
# 用户的唯一性(用户名, 邮箱)检查器
module UserUniqueFinders
  extend ActiveSupport::Concern

  module ClassMethods
    ##
    # 检查用户名是否存在
    #     username - 要检查的用户名
    #     exclude_user_id - 检查时要排除的用户, 避免检查用户自身
    #
    #  使用方法:
    #     User.username_exists?('abc123')
    #
    #     对于已存在用户 abc123, 想检查 'abc123' 是否已存在, 表示他是使用这个用户名, 这时排除他的本身的记录
    #     User.username_exists?('abc123', 123)
    def username_exists?(username, exclude_user_id = nil)
      user = User.by_uname(username)
      user.present? and (exclude_user_id.blank? or user.id != exclude_user_id)
    end

    ##
    # 检查邮箱是否存在
    #     email - 要检查的邮箱
    #     exclude_user_id - 检查时要排除的用户, 避免检查用户自身
    #
    #  使用方法:
    #     类似 username_exists?
    def email_exists?(email, exclude_user_id = nil)
      user = User.by_email(email)
      user.present? and (exclude_user_id.blank? or user.id != exclude_user_id)
    end

  end
end