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

ActiveRecord::Schema.define(version: 20140130222528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contacts", force: true do |t|
    t.integer  "property_id"
    t.string   "name"
    t.string   "phone"
    t.string   "url"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["property_id"], name: "index_contacts_on_property_id", using: :btree

  create_table "hunt_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "hunt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hunt_users", ["hunt_id"], name: "index_hunt_users_on_hunt_id", using: :btree
  add_index "hunt_users", ["user_id"], name: "index_hunt_users_on_user_id", using: :btree

  create_table "hunts", force: true do |t|
    t.integer  "target_beds"
    t.string   "target_cost_unit"
    t.integer  "target_cost_value"
    t.string   "location"
    t.decimal  "latitude",          precision: 10, scale: 6
    t.decimal  "longitude",         precision: 10, scale: 6
    t.decimal  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "properties", force: true do |t|
    t.integer  "hunt_id"
    t.string   "name"
    t.string   "location"
    t.decimal  "latitude",      precision: 10, scale: 6
    t.decimal  "longitude",     precision: 10, scale: 6
    t.boolean  "enquired"
    t.boolean  "agent_replied"
    t.boolean  "viewed"
    t.datetime "viewing_time"
    t.boolean  "liked"
    t.boolean  "disliked"
    t.boolean  "unavailable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["hunt_id"], name: "index_properties_on_hunt_id", using: :btree

  create_table "property_attributes", force: true do |t|
    t.integer  "property_id"
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "property_attributes", ["property_id"], name: "index_property_attributes_on_property_id", using: :btree

  create_table "property_media", force: true do |t|
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "property_media", ["property_id"], name: "index_property_media_on_property_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "provider_uid"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
