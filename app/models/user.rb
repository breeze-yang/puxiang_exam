class User < ApplicationRecord

  include UserFinders

  acts_as_cached(:version => 1, :expires_in => 1.week)


  ##
  # 返回用户对应app的用户令牌, 应用可以通过 用户uuid + 用户令牌 进行登录
  # 同一用户, 不用的应用有不同的用户令牌. 非通用.
  # 如, 用户A , 对于应用X, TA的用户令牌就是 X'; 对于应用Y, Ta的用户令牌就是 Y';
  # 用户A不能用 Y' 在应用X中登录;
  #
  # 另外, 用户令牌与用户的密码相关, 当用户修改了密码, Ta的所有的应用的用户令牌也发生改变; 之前的用户令牌全部失效.
  def user_token(app_secret)
    ::Digest::MD5.hexdigest("#{self.Password}_#{self.Salt}_#{app_secret}")
  end


end
