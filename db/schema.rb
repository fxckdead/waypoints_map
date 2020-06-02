# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_01_213409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "vehicles", force: :cascade do |t|
    t.string "identifier", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier"], name: "index_vehicles_on_identifier", unique: true
  end

  create_table "waypoints", force: :cascade do |t|
    t.bigint "vehicle_id", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "sent_at", null: false
    t.datetime "created_at", null: false
    t.index ["sent_at", "vehicle_id"], name: "index_waypoints_on_sent_at_and_vehicle_id"
    t.index ["sent_at"], name: "index_waypoints_on_sent_at"
    t.index ["vehicle_id"], name: "index_waypoints_on_vehicle_id"
  end

  add_foreign_key "waypoints", "vehicles"
end
