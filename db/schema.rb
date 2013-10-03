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

ActiveRecord::Schema.define(version: 20130816100935) do

  create_table "accounts", force: true do |t|
    t.decimal  "total",      precision: 18, scale: 0
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["client_id"], name: "index_accounts_on_user_id"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bonus_programs", force: true do |t|
    t.string   "name"
    t.decimal  "rate",       precision: 18, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "human_name"
  end

  create_table "roles", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "trips", force: true do |t|
    t.integer  "user_id"
    t.datetime "trip_date",                                        null: false
    t.integer  "duration"
    t.decimal  "price",       precision: 18, scale: 0, default: 0
    t.integer  "bonus_point",                          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.integer  "added_bonus"
    t.integer  "orders_id"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id"

  create_table "users", force: true do |t|
    t.integer  "email",                  limit: 8,              null: false
    t.string   "encrypted_password",               default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "card_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "fio"
    t.integer  "bonus_program_id"
    t.integer  "natural_person_id",                default: 1,  null: false
    t.string   "mail"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
