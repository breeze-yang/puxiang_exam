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

ActiveRecord::Schema.define(version: 20161126125754) do

  create_table "affiliate_apps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "affiliate_id"
    t.string   "app_id",       limit: 50,                           comment: "用来描述该app"
    t.string   "app_name",     limit: 100,                          comment: "用来描述该app"
    t.string   "app_key",      limit: 36,                           comment: "访问接口所有的app_key"
    t.string   "app_secret",   limit: 36,                           comment: "app所有的secret"
    t.integer  "status",                   default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["affiliate_id"], name: "index_affiliate_apps_on_affiliate_id", using: :btree
    t.index ["app_id"], name: "index_affiliate_apps_on_app_id", unique: true, using: :btree
    t.index ["app_key"], name: "index_affiliate_apps_on_app_key", unique: true, using: :btree
    t.index ["app_name"], name: "index_affiliate_apps_on_app_name", unique: true, using: :btree
  end

  create_table "affiliates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "aff_uuid",   limit: 36,                                   comment: "合作方uuid"
    t.string   "aff_name",   limit: 100,                                  comment: "合作方名字"
    t.string   "aff_type",   limit: 50,  default: "company",              comment: "合作方类型"
    t.integer  "status",                 default: 0,                      comment: "合作方状态"
    t.string   "mobile",     limit: 20,                                   comment: "合作方联系方式"
    t.string   "memo",                                                    comment: "合作方备注"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["aff_name"], name: "index_affiliates_on_aff_name", unique: true, using: :btree
    t.index ["aff_uuid"], name: "index_affiliates_on_aff_uuid", unique: true, using: :btree
    t.index ["mobile"], name: "index_affiliates_on_mobile", unique: true, using: :btree
  end

  create_table "meetups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                                 null: false
    t.string   "title",                                   null: false
    t.text     "body",          limit: 65535,             null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "replies_count",               default: 0, null: false, comment: "回复数统计"
  end

  create_table "replies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",       limit: 65535
    t.integer  "user_id"
    t.integer  "meetup_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["meetup_id"], name: "index_replies_on_meetup_id", using: :btree
    t.index ["user_id"], name: "index_replies_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username",        limit: 32, null: false, comment: "用户名"
    t.string   "password_digest",            null: false, comment: "用户密码"
    t.string   "email",                      null: false, comment: "邮箱"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "remember_digest"
    t.index ["email"], name: "unique_email", unique: true, using: :btree
    t.index ["username"], name: "unique_username", unique: true, using: :btree
  end

  add_foreign_key "affiliate_apps", "affiliates"
  add_foreign_key "replies", "meetups"
  add_foreign_key "replies", "users"
end
