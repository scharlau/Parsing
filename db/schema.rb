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

ActiveRecord::Schema.define(version: 20171103172738) do

  create_table "deployments", force: :cascade do |t|
    t.integer "BearID"
    t.integer "PTT_ID"
    t.decimal "capture_lat"
    t.decimal "capture_long"
    t.string "Sex"
    t.string "Age_class"
    t.string "Ear_applied"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.integer "deployment_id"
    t.integer "deployID"
    t.string "recieved"
    t.decimal "latitude"
    t.decimal "longitude"
    t.decimal "temperature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deployment_id"], name: "index_statuses_on_deployment_id"
  end

end
