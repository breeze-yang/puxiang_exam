##
# 用户的验证器
# 考虑到随着发展，用户系统一定会越来越复杂
# 相应的用户的验证也会复杂。
# 所以将用户验证器单独模块化
class UserValidator < ActiveModel::Validator

  def validate(user)
    username_valid?(user)
    email_valid?(user)
  end

  def username_valid?(user)
    return unless user.username_changed?

    result = User.username_format_valid?(user.username)
    if result.is_failure?
      return user.errors.add :username, result.data[:error_detail]
    end

    if User.username_exists?(user.username, user.id)
      user.errors.add :username, '用户名已被注册'
    end
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  def email_valid?(user)
    return unless user.email_changed?

    unless user.email.match VALID_EMAIL_REGEX
      return  user.errors.add :email,  '邮箱格式不对'
    end

    if User.email_exists?(user.email, user.id)
      user.errors.add :email, '邮箱已被注册'
    end
  end

  def self.is_email?(email)
    email.to_s.match(VALID_EMAIL_REGEX).present?
  end

end