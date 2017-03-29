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

ActiveRecord::Schema.define(version: 20170323142713) do

  create_table "charts", force: :cascade do |t|
    t.string   "key"
    t.text     "configuration"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["key"], name: "index_charts_on_key", unique: true
  end

  create_table "emails", force: :cascade do |t|
    t.text     "message"
    t.integer  "site_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_emails_on_site_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "email_id",   null: false
    t.string   "key",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
    t.integer  "integer"
    t.string   "string"
    t.decimal  "decimal"
    t.index ["email_id"], name: "index_reports_on_email_id"
    t.index ["key"], name: "index_reports_on_key"
  end

  create_table "sites", force: :cascade do |t|
    t.string   "name",                          null: false
    t.string   "url",                           null: false
    t.string   "email_address",                 null: false
    t.boolean  "verified",      default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["email_address"], name: "index_sites_on_email_address", unique: true
    t.index ["url"], name: "index_sites_on_url", unique: true
  end

end
