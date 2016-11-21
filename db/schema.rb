# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161121131911) do

  create_table "meetups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id",                  null: false
    t.text     "body",       limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "replies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id",                  null: false
    t.integer  "meetup_id",                null: false
    t.text     "body",       limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["meetup_id"], name: "index_meetup", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "password",   limit: 32, null: false, comment: "用户密码32位"
    t.string   "username",   limit: 32, null: false, comment: "用户名"
    t.integer  "mobile",                null: false, comment: "手机号"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["mobile"], name: "unique_mobile", unique: true, using: :btree
    t.index ["username"], name: "unique_username", unique: true, using: :btree
  end

end
