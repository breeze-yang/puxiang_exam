##
# 用户的验证器
# 考虑到随着发展，用户系统一定会越来越复杂
# 相应的用户的验证也会复杂。
# 所以将用户验证器单独模块化
class UserValidator < ActiveModel::Validator

  def validate(user)
    errors = [
        username_valid?(user).to_a,
        email_valid?(user).to_a,
    ].flatten

    errors.each { |error| user.errors.add :base, error }
  end

  def username_valid?(user)
    return unless user.username_changed?

    result = User.username_format_valid?(user.username)
    if result.is_failure?
      return [ result.data[:error_detail] ]
    end

    ['用户名已被注册'] if User.username_exists?(user.username, user.id)
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  def email_valid?(user)
    return unless user.email_changed?

    return ['邮箱格式不对'] unless user.email.match VALID_EMAIL_REGEX

    ['邮箱已被注册'] if User.email_exists?(user.email, user.id)
  end

  def self.is_email?(email)
    email.match(VALID_EMAIL_REGEX).present?
  end

end