# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_10_223914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "facts", force: :cascade do |t|
    t.string "trigger", null: false
    t.string "result", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "verb"
  end

  create_table "items", force: :cascade do |t|
    t.string "what", null: false
    t.string "placed_by", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nouns", force: :cascade do |t|
    t.string "what", null: false
    t.string "placed_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "silence_requests", force: :cascade do |t|
    t.string "requester", null: false
    t.datetime "silence_until", null: false
  end

end
