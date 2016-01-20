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

ActiveRecord::Schema.define(version: 20160120012329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "facts", force: :cascade do |t|
    t.string   "trigger",    null: false
    t.string   "result",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "verb"
  end

  create_table "items", force: :cascade do |t|
    t.string   "what",       null: false
    t.string   "placed_by",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "silence_requests", force: :cascade do |t|
    t.string   "requester",     null: false
    t.datetime "silence_until", null: false
  end

end
