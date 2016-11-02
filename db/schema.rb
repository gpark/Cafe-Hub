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

ActiveRecord::Schema.define(version: 20161102000309) do

  create_table "entry_occurences", force: :cascade do |t|
    t.boolean  "su"
    t.boolean  "m"
    t.boolean  "tu"
    t.boolean  "w"
    t.boolean  "th"
    t.boolean  "f"
    t.boolean  "sa"
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "preference_entry_id"
  end

  add_index "entry_occurences", ["preference_entry_id"], name: "index_entry_occurences_on_preference_entry_id"

  create_table "preference_entries", force: :cascade do |t|
    t.string   "preference_type"
    t.text     "comments"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "preference_id"
  end

  add_index "preference_entries", ["preference_id"], name: "index_preference_entries_on_preference_id"

  create_table "preferences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "preferences", ["user_id"], name: "index_preferences_on_user_id"

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
