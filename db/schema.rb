# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160125160633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.text     "body",                              null: false
    t.integer  "money",             default: 0
    t.integer  "sender_id",                         null: false
    t.string   "messageable_type",                  null: false
    t.integer  "messageable_id",                    null: false
    t.integer  "parent_message_id"
    t.boolean  "read",              default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "required_rank"
    t.index ["messageable_type", "messageable_id"], name: "index_messages_on_messageable_type_and_messageable_id", using: :btree
    t.index ["parent_message_id"], name: "index_messages_on_parent_message_id", using: :btree
    t.index ["sender_id"], name: "index_messages_on_sender_id", using: :btree
  end

  create_table "nation_memberships", force: :cascade do |t|
    t.integer  "rank"
    t.string   "member_title", default: "Member",   null: false
    t.string   "state",        default: "inactive", null: false
    t.integer  "province_id",                       null: false
    t.integer  "nation_id",                         null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["nation_id"], name: "index_nation_memberships_on_nation_id", using: :btree
    t.index ["province_id"], name: "index_nation_memberships_on_province_id", using: :btree
  end

  create_table "nations", force: :cascade do |t|
    t.string   "name",              null: false
    t.text     "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "user_title",                     null: false
    t.string   "currency_name",                  null: false
    t.string   "government_type",                null: false
    t.string   "resource_1",                     null: false
    t.string   "resource_2",                     null: false
    t.text     "description"
    t.integer  "population",        default: 0,  null: false
    t.integer  "money",             default: 0,  null: false
    t.integer  "infrastructure",    default: 0,  null: false
    t.integer  "technology",        default: 0,  null: false
    t.integer  "local_tax_rate",    default: 15, null: false
    t.integer  "user_id",                        null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
    t.index ["user_id"], name: "index_provinces_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                            null: false
    t.string   "password_digest",                     null: false
    t.string   "email",                               null: false
    t.string   "session_token",                       null: false
    t.boolean  "admin",               default: false, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["session_token"], name: "index_users_on_session_token", using: :btree
    t.index ["username"], name: "index_users_on_username", using: :btree
  end

end
