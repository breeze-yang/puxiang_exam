class InitMysqlDb < ActiveRecord::Migration[5.0]
  def change

    create_table(:users, force: :cascade) do |t|
      t.string  :password, length: 32, null: false, comment: '用户密码32位'
      t.string  :username, length: 32, null: false, comment: '用户名'
      t.integer :mobile,               null: false, comment: '手机号'
      t.timestamps
    end
    add_index(:users, :username, unique: true, name: :unique_username)
    add_index(:users, :mobile,   unique: true, name: :unique_mobile)


    create_table :meetups, force: :cascade do |t|
      t.integer  :user_id,    null: false
      t.text     :body,       null: false
      t.timestamps
    end

    create_table :replies, force: :cascade do |t|
      t.integer  :user_id,    null: false
      t.integer  :meetup_id,  null: false
      t.text     :body,       null: false
      t.timestamps
    end
    add_index(:replies, :meetup_id, name: :index_meetup)

  end
end
