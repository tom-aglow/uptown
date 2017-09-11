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

ActiveRecord::Schema.define(version: 20170911002427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "barbers", force: :cascade do |t|
    t.string "first_name", limit: 30, null: false
    t.string "last_name", limit: 30, null: false
    t.string "avatar", limit: 100, default: "default.jpg", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "full_name", limit: 50, null: false
    t.string "email", limit: 50, null: false
    t.string "phone", limit: 12, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requisitions", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "service_id", null: false
    t.bigint "shift_id", null: false
    t.string "status", limit: 20, default: "new", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_id", "client_id", "service_id"], name: "index_requisitions_on_shift_id_and_client_id_and_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.date "date", null: false
    t.string "time", limit: 8, null: false
    t.bigint "barber_id", null: false
    t.boolean "is_free", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["barber_id"], name: "index_shifts_on_barber_id"
    t.index ["date", "time", "barber_id"], name: "index_shifts_on_date_and_time_and_barber_id", unique: true
  end

  create_table "testimonials", force: :cascade do |t|
    t.bigint "requisition_id", null: false
    t.text "body", null: false
    t.integer "grade", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requisition_id"], name: "index_testimonials_on_requisition_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", limit: 30, null: false
    t.string "email", default: "", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "requisitions", "clients"
  add_foreign_key "requisitions", "services"
  add_foreign_key "requisitions", "shifts"
  add_foreign_key "shifts", "barbers"
  add_foreign_key "testimonials", "requisitions"
end
