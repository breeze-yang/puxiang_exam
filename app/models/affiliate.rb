=begin
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | int(11)      | NO   | PRI | NULL    | auto_increment |
| aff_uuid   | varchar(36)  | YES  | UNI | NULL    |                |
| aff_name   | varchar(100) | YES  | UNI | NULL    |                |
| aff_type   | varchar(50)  | YES  |     | company |                |
| status     | int(11)      | YES  |     | 0       |                |
| mobile     | varchar(20)  | YES  | UNI | NULL    |                |
| memo       | varchar(255) | YES  |     | NULL    |                |
| created_at | datetime     | NO   |     | NULL    |                |
| updated_at | datetime     | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
=end

class Affiliate < ApplicationRecord
  has_many :affiliate_apps, dependent: :destroy

end
