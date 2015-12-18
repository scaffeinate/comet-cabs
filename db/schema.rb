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

ActiveRecord::Schema.define(version: 20151218183707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "oauth_token"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.string   "source",               default: "0.0", null: false
    t.string   "destination",          default: "0.0", null: false
    t.decimal  "distance",             default: 0.0,   null: false
    t.decimal  "price",                default: 5.0,   null: false
    t.integer  "status",               default: 0,     null: false
    t.integer  "user_id"
    t.integer  "driver_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "cab_type_id",          default: 0,     null: false
    t.string   "source_name"
    t.string   "destination_name"
    t.string   "source_place_id"
    t.string   "destination_place_id"
  end

  add_index "bookings", ["cab_type_id"], name: "index_bookings_on_cab_type_id", using: :btree
  add_index "bookings", ["driver_id"], name: "index_bookings_on_driver_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "cab_types", force: :cascade do |t|
    t.decimal  "base_fare",         default: 5.0, null: false
    t.integer  "number_of_persons", default: 4,   null: false
    t.string   "name",              default: "",  null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.float    "per_mile_fare",     default: 1.0, null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "name",                   default: "",   null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "avatar"
    t.string   "phone",                  default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "license",                default: "",   null: false
    t.string   "vehicle",                default: "",   null: false
    t.integer  "cab_type_id",            default: 0,    null: false
    t.float    "latitude",               default: 0.0,  null: false
    t.float    "longitude",              default: 0.0,  null: false
    t.boolean  "available",              default: true, null: false
  end

  add_index "drivers", ["cab_type_id"], name: "index_drivers_on_cab_type_id", using: :btree
  add_index "drivers", ["email"], name: "index_drivers_on_email", unique: true, using: :btree
  add_index "drivers", ["reset_password_token"], name: "index_drivers_on_reset_password_token", unique: true, using: :btree

  create_table "payments", force: :cascade do |t|
    t.string   "holder_name", default: "", null: false
    t.string   "card_number", default: "", null: false
    t.string   "card_cvv",    default: "", null: false
    t.string   "card_expiry", default: "", null: false
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "",    null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "avatar"
    t.string   "phone",                  default: "",    null: false
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
    t.boolean  "is_card_info_set",       default: false, null: false
    t.boolean  "is_password_set",        default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "authentications", "users"
  add_foreign_key "bookings", "cab_types"
  add_foreign_key "bookings", "drivers"
  add_foreign_key "bookings", "users"
  add_foreign_key "drivers", "cab_types"
  add_foreign_key "payments", "users"
end
