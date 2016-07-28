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

ActiveRecord::Schema.define(version: 20160728211151) do

  create_table "stories", force: :cascade do |t|
    t.text     "one"
    t.text     "two"
    t.text     "three"
    t.text     "four"
    t.text     "five"
    t.text     "six"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "one_a"
    t.text     "one_b"
    t.text     "one_c"
    t.integer  "one_choice"
    t.text     "two_a"
    t.text     "two_b"
    t.text     "two_c"
    t.integer  "two_choice"
    t.text     "three_a"
    t.text     "three_b"
    t.text     "three_c"
    t.integer  "three_choice"
    t.text     "four_a"
    t.text     "four_b"
    t.text     "four_c"
    t.integer  "four_choice"
    t.text     "five_a"
    t.text     "five_b"
    t.text     "five_c"
    t.integer  "five_choice"
    t.text     "six_a"
    t.text     "six_b"
    t.text     "six_c"
    t.integer  "six_choice"
  end

end
