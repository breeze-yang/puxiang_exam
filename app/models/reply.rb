=begin
+------------+----------+------+-----+---------+----------------+
| Field      | Type     | Null | Key | Default | Extra          |
+------------+----------+------+-----+---------+----------------+
| id         | int(11)  | NO   | PRI | NULL    | auto_increment |
| body       | text     | YES  |     | NULL    |                |
| user_id    | int(11)  | YES  | MUL | NULL    |                |
| meetup_id  | int(11)  | YES  | MUL | NULL    |                |
| created_at | datetime | NO   |     | NULL    |                |
| updated_at | datetime | NO   |     | NULL    |                |
+------------+----------+------+-----+---------+----------------+
=end
class Reply < ApplicationRecord

  validates :user_id, :meetup_id, :body, presence: true

  belongs_to :user
  belongs_to :meetup
end
