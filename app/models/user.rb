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
  has_many :replies

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

end
