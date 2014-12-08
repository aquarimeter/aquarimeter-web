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

ActiveRecord::Schema.define(version: 20141208093348) do

  create_table "aquariums", force: true do |t|
    t.integer  "user_id",                                 null: false
    t.string   "name",                                    null: false
    t.decimal  "ideal_temp_low",  precision: 5, scale: 2, null: false
    t.decimal  "ideal_temp_high", precision: 5, scale: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aquariums", ["name"], name: "index_aquariums_on_name"
  add_index "aquariums", ["user_id"], name: "index_aquariums_on_user_id"

  create_table "images", force: true do |t|
    t.string   "image",                             null: false
    t.string   "description",                       null: false
    t.string   "processed_image",                   null: false
    t.string   "unprocessed_image",                 null: false
    t.boolean  "avatar",            default: false, null: false
    t.integer  "aquarium_id",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["aquarium_id"], name: "index_images_on_aquarium_id"

  create_table "sensor_readings", force: true do |t|
    t.integer  "aquarium_id",                         null: false
    t.decimal  "ph",          precision: 5, scale: 2, null: false
    t.decimal  "temperature", precision: 5, scale: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sensor_readings", ["aquarium_id"], name: "index_sensor_readings_on_aquarium_id"

  create_table "users", force: true do |t|
    t.string   "email",                              null: false
    t.string   "encrypted_password",                 null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0, null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name",                         null: false
    t.string   "last_name",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token"
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
