=begin
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | int(11)      | NO   | PRI | NULL    | auto_increment |
| password   | varchar(32)  | NO   |     | NULL    |                |
| username   | varchar(32)  | NO   | UNI | NULL    |                |
| email      | varchar(255) | NO   | UNI | NULL    |                |
| created_at | datetime     | NO   |     | NULL    |                |
| updated_at | datetime     | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
=end
class User < ApplicationRecord
  include UserFinders
  include UserUniqueFinders
  include UsernameValidator

  acts_as_cached(:version => 1, :expires_in => 1.days)

  attr_accessor :remember_token

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates_with UserValidator

  has_many :meetups

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  ##
  # 模仿 ActiveModel 内置的 SecurePassword 进行加密 token等
  # 具体通过 ActiveModel::SecurePassword.password= 这个方法来了解
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  ##
  # 模仿 ActiveModel 内置的 SecurePassword 进行验证 token等
  # 具体通过 ActiveModel::SecurePassword.authenticate 这个方法来了解
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # 在数据库中存储用BCrypt加密的remember_digest，记录用户持久登录。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def send_activation_email
    AccountMailer.account_activation(self.id).deliver_now
  end
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
