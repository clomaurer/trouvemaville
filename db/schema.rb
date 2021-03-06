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

ActiveRecord::Schema.define(version: 2021_05_18_123329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "population"
    t.integer "commodity_count"
    t.integer "house_marketprice"
    t.boolean "primary_school", default: false
    t.boolean "secondary_school", default: false
    t.boolean "doctor", default: false
    t.integer "age_average"
    t.boolean "supermarket", default: false
    t.integer "land_marketprice"
    t.integer "flat_marketprice"
    t.float "latitude"
    t.float "longitude"
    t.string "fibre"
    t.string "network"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "geocode"
    t.integer "rating", default: 0, null: false
    t.string "photo"
  end

  create_table "comparators", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_comparators_on_user_id"
  end

  create_table "compared_cities", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.bigint "comparator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_compared_cities_on_city_id"
    t.index ["comparator_id"], name: "index_compared_cities_on_comparator_id"
  end

  create_table "favorite_cities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "saved_search_id", null: false
    t.index ["city_id"], name: "index_favorite_cities_on_city_id"
    t.index ["saved_search_id"], name: "index_favorite_cities_on_saved_search_id"
    t.index ["user_id"], name: "index_favorite_cities_on_user_id"
  end

  create_table "saved_searches", force: :cascade do |t|
    t.integer "budget_max"
    t.boolean "primary_school", default: false
    t.boolean "secondary_school", default: false
    t.integer "age_average"
    t.boolean "supermarket", default: false
    t.boolean "network", default: false
    t.boolean "fibre", default: false
    t.integer "min_surface"
    t.integer "max_distance_km"
    t.integer "max_distance_minutes"
    t.string "property_type"
    t.string "start_city"
    t.boolean "doctor", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "commodity", default: false
    t.integer "max_population"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comparators", "users"
  add_foreign_key "compared_cities", "cities"
  add_foreign_key "compared_cities", "comparators"
  add_foreign_key "favorite_cities", "cities"
  add_foreign_key "favorite_cities", "saved_searches"
  add_foreign_key "favorite_cities", "users"
end
