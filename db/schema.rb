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

ActiveRecord::Schema.define(version: 20150304002440) do

  create_table "performance_snapshots", force: :cascade do |t|
    t.integer  "first_byte"
    t.integer  "first_paint"
    t.integer  "render"
    t.integer  "load_time"
    t.integer  "full_load_time"
    t.integer  "total_bytes"
    t.integer  "requests"
    t.text     "url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "visual_complete"
    t.integer  "target_id"
  end

  create_table "targets", force: :cascade do |t|
    t.string   "label"
    t.text     "script"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
