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

ActiveRecord::Schema.define(version: 20150613201744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_dates", force: :cascade do |t|
    t.integer  "event_id",                      null: false
    t.datetime "time_begin",                    null: false
    t.datetime "time_end",                      null: false
    t.integer  "tickets_total", default: 0,     null: false
    t.integer  "tickets_sold"
    t.boolean  "waitlist",      default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "event_dates", ["event_id"], name: "index_event_dates_on_event_id", using: :btree

  create_table "event_items", force: :cascade do |t|
    t.integer  "event_id",                              null: false
    t.integer  "position",              default: 0,     null: false
    t.string   "name",                                  null: false
    t.text     "description",                           null: false
    t.boolean  "itinerary_item",        default: false
    t.string   "itinerary_description"
    t.datetime "itinerary_begin"
    t.datetime "itinerary_end"
    t.boolean  "show_map",              default: false
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

  add_index "event_items", ["event_id"], name: "index_event_items_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "user_id",                              null: false
    t.boolean  "publish",              default: false
    t.boolean  "private_event",        default: false
    t.boolean  "package",              default: false
    t.string   "title",                                null: false
    t.text     "short_description",                    null: false
    t.text     "description"
    t.integer  "ticket_price",                         null: false
    t.integer  "position",             default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "preview_file_name"
    t.string   "preview_content_type"
    t.integer  "preview_file_size"
    t.datetime "preview_updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "inquiries", force: :cascade do |t|
    t.integer  "request_type"
    t.string   "first_name",   null: false
    t.string   "last_name",    null: false
    t.string   "email",        null: false
    t.string   "phone"
    t.text     "notes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id",                              null: false
    t.integer  "event_id",                             null: false
    t.integer  "event_date_id",                        null: false
    t.integer  "tickets",              default: 1,     null: false
    t.integer  "ticket_price",                         null: false
    t.string   "full_name",                            null: false
    t.integer  "amount",                               null: false
    t.string   "stripe_charge_id",                     null: false
    t.string   "card_token"
    t.string   "stripe_email"
    t.string   "description"
    t.string   "statement_descriptor"
    t.string   "status"
    t.boolean  "paid"
    t.boolean  "refunded",             default: false
    t.string   "card_brand"
    t.string   "card_four"
    t.string   "card_exp"
    t.string   "address",                              null: false
    t.string   "city",                                 null: false
    t.string   "state",                                null: false
    t.integer  "zipcode",                              null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "payments", ["event_date_id"], name: "index_payments_on_event_date_id", using: :btree
  add_index "payments", ["event_id", "event_date_id"], name: "index_payments_on_event_id_and_event_date_id", using: :btree
  add_index "payments", ["event_id"], name: "index_payments_on_event_id", using: :btree
  add_index "payments", ["user_id", "event_date_id"], name: "index_payments_on_user_id_and_event_date_id", using: :btree
  add_index "payments", ["user_id", "event_id", "event_date_id"], name: "index_payments_on_user_id_and_event_id_and_event_date_id", using: :btree
  add_index "payments", ["user_id", "event_id"], name: "index_payments_on_user_id_and_event_id", using: :btree
  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "user_waitlists", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "waitlist_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_waitlists", ["user_id", "waitlist_id"], name: "index_user_waitlists_on_user_id_and_waitlist_id", using: :btree
  add_index "user_waitlists", ["user_id"], name: "index_user_waitlists_on_user_id", using: :btree
  add_index "user_waitlists", ["waitlist_id"], name: "index_user_waitlists_on_waitlist_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.string   "phone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "waitlists", force: :cascade do |t|
    t.integer  "event_id",                     null: false
    t.integer  "event_date_id",                null: false
    t.integer  "limit",                        null: false
    t.integer  "total_users",   default: 0,    null: false
    t.boolean  "active",        default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "waitlists", ["event_date_id"], name: "index_waitlists_on_event_date_id", using: :btree
  add_index "waitlists", ["event_id", "event_date_id"], name: "index_waitlists_on_event_id_and_event_date_id", using: :btree
  add_index "waitlists", ["event_id"], name: "index_waitlists_on_event_id", using: :btree

end
