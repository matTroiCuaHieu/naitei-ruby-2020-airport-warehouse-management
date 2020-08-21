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

ActiveRecord::Schema.define(version: 2020_08_21_070636) do

  create_table "components", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "amount"
    t.datetime "time"
    t.text "reason"
    t.string "status"
    t.bigint "schedule_id", null: false
    t.bigint "component_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["component_id"], name: "index_histories_on_component_id"
    t.index ["schedule_id"], name: "index_histories_on_schedule_id"
  end

  create_table "locations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.boolean "filled"
    t.bigint "warehouse_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["warehouse_id"], name: "index_locations_on_warehouse_id"
  end

  create_table "planes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "time"
    t.text "reason"
    t.bigint "location_id", null: false
    t.bigint "plane_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "accept"
    t.boolean "processing", default: true
    t.bigint "user_id"
    t.index ["location_id"], name: "index_schedules_on_location_id"
    t.index ["plane_id"], name: "index_schedules_on_plane_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "units", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.boolean "manager", default: false
    t.string "activation_digest"
    t.datetime "activated_at"
    t.boolean "activated", default: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.bigint "warehouse_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "unit_id"
    t.index ["unit_id"], name: "index_users_on_unit_id"
    t.index ["warehouse_id"], name: "index_users_on_warehouse_id"
  end

  create_table "warehouses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "area"
    t.bigint "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "histories", "components"
  add_foreign_key "histories", "schedules"
  add_foreign_key "locations", "warehouses"
  add_foreign_key "schedules", "locations"
  add_foreign_key "schedules", "planes"
  add_foreign_key "schedules", "users"
  add_foreign_key "users", "units"
  add_foreign_key "users", "warehouses"
end
