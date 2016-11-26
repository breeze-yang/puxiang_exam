=begin
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int(11)      | NO   | PRI | NULL    | auto_increment |
| affiliate_id | int(11)      | YES  | MUL | NULL    |                |
| app_id       | varchar(50)  | YES  | UNI | NULL    |                |
| app_name     | varchar(100) | YES  | UNI | NULL    |                |
| app_key      | varchar(36)  | YES  | UNI | NULL    |                |
| app_secret   | varchar(36)  | YES  |     | NULL    |                |
| status       | int(11)      | YES  |     | 0       |                |
| created_at   | datetime     | NO   |     | NULL    |                |
| updated_at   | datetime     | NO   |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+

=end

class AffiliateApp < ApplicationRecord

  belongs_to :affiliate

  acts_as_cached :version => 1, :expires_in => 1.week

  def self.find_by_app_key(app_key)
    self.fetch_by_uniq_keys(app_key: app_key)
  end

end
