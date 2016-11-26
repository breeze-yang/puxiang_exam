=begin
+---------------+--------------+------+-----+---------+----------------+
| Field         | Type         | Null | Key | Default | Extra          |
+---------------+--------------+------+-----+---------+----------------+
| id            | int(11)      | NO   | PRI | NULL    | auto_increment |
| user_id       | int(11)      | NO   |     | NULL    |                |
| title         | varchar(255) | NO   |     | NULL    |                |
| body          | text         | NO   |     | NULL    |                |
| created_at    | datetime     | NO   |     | NULL    |                |
| updated_at    | datetime     | NO   |     | NULL    |                |
| replies_count | int(11)      | NO   |     | 0       |                |
+---------------+--------------+------+-----+---------+----------------+
=end
class   Meetup < ApplicationRecord

  acts_as_cached(:version => 1, :expires_in => 1.week)

  validates :user_id, :title, :body, presence: true

  has_many :replies, dependent: :destroy
  belongs_to :user

end
