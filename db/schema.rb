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

ActiveRecord::Schema.define(version: 20151015150313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "atts", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "atts", ["user_id"], name: "index_atts_on_user_id", using: :btree

  create_table "atts_teas", force: true do |t|
    t.integer "att_id"
    t.integer "tea_id"
  end

  add_index "atts_teas", ["att_id"], name: "index_atts_teas_on_att_id", using: :btree
  add_index "atts_teas", ["tea_id"], name: "index_atts_teas_on_tea_id", using: :btree

  create_table "exclusions", force: true do |t|
    t.string   "attr"
    t.string   "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exclusions", ["user_id"], name: "index_exclusions_on_user_id", using: :btree

  create_table "notes", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "preferences", force: true do |t|
    t.text     "name"
    t.text     "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preferences", ["user_id"], name: "index_preferences_on_user_id", using: :btree

  create_table "tea_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teas", force: true do |t|
    t.string   "name"
    t.string   "stock"
    t.text     "notes"
    t.string   "url"
    t.integer  "user_id"
    t.integer  "tea_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vendor"
  end

  add_index "teas", ["tea_type_id"], name: "index_teas_on_tea_type_id", using: :btree
  add_index "teas", ["user_id"], name: "index_teas_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "wishlists", force: true do |t|
    t.string   "name"
    t.text     "notes"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wishlists", ["user_id"], name: "index_wishlists_on_user_id", using: :btree

end
