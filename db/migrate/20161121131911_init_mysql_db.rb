##
# when creating database, please set default utf8
#
class InitMysqlDb < ActiveRecord::Migration[5.0]
  def change

    create_table(:users, force: :cascade) do |t|
      t.string  :username, limit: 32, null: false, comment: '用户名'
      t.string  :password_digest,     null: false, comment: '用户密码'
      t.string  :email,               null: false, comment: '邮箱'
      t.timestamps
    end
    add_index(:users, :username, unique: true, name: :unique_username)
    add_index(:users, :email,    unique: true, name: :unique_email)


    create_table :meetups, force: :cascade do |t|
      t.integer  :user_id,    null: false
      t.string   :title,      null: false
      t.text     :body,       null: false
      t.timestamps
    end

  end
end
