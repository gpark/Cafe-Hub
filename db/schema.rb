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

ActiveRecord::Schema.define(version: 20161117054050) do

  create_table "assignments", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.integer  "facility_id"
    t.integer  "assignments_week_id"
    t.string   "day"
    t.string   "start_time"
    t.string   "end_time"
  end

  add_index "assignments", ["assignments_week_id"], name: "index_assignments_on_assignments_week_id"
  add_index "assignments", ["facility_id"], name: "index_assignments_on_facility_id"
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id"

  create_table "assignments_weeks", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facilities", force: :cascade do |t|
    t.string   "name"
    t.integer  "ppl_per_shift"
    t.string   "su_start"
    t.string   "su_end"
    t.string   "m_start"
    t.string   "m_end"
    t.string   "tu_start"
    t.string   "tu_end"
    t.string   "w_start"
    t.string   "w_end"
    t.string   "th_start"
    t.string   "th_end"
    t.string   "f_start"
    t.string   "f_end"
    t.string   "sa_start"
    t.string   "sa_end"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "occurences", force: :cascade do |t|
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
    t.integer  "assignment_id"
  end

  add_index "occurences", ["assignment_id"], name: "index_occurences_on_assignment_id"
  add_index "occurences", ["preference_entry_id"], name: "index_occurences_on_preference_entry_id"

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

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true

  create_table "subs", force: :cascade do |t|
    t.text     "comments"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "assignment_id"
  end

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
