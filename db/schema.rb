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

ActiveRecord::Schema.define(version: 20170108194722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "brand_name"
    t.integer  "brand_state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.integer  "category_state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "city_name"
    t.integer  "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_cities_on_region_id", using: :btree
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "price_state"
    t.integer  "actual_price"
    t.integer  "product_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["product_id"], name: "index_prices_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_name"
    t.integer  "product_state"
    t.integer  "provider_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "brand_id"
    t.integer  "category_id"
    t.string   "product_code"
    t.index ["brand_id"], name: "index_products_on_brand_id", using: :btree
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["provider_id"], name: "index_products_on_provider_id", using: :btree
  end

  create_table "providers", force: :cascade do |t|
    t.string   "provider_name"
    t.string   "provider_rut"
    t.string   "provider_tel"
    t.string   "provider_email"
    t.integer  "city_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "provider_address"
    t.integer  "region_id"
    t.index ["city_id"], name: "index_providers_on_city_id", using: :btree
    t.index ["region_id"], name: "index_providers_on_region_id", using: :btree
  end

  create_table "purchase_details", force: :cascade do |t|
    t.integer  "purchase_quantity"
    t.integer  "purchase_price"
    t.integer  "purchase_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "product_id"
    t.index ["product_id"], name: "index_purchase_details_on_product_id", using: :btree
    t.index ["purchase_id"], name: "index_purchase_details_on_purchase_id", using: :btree
  end

  create_table "purchase_states", force: :cascade do |t|
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "purchase_total"
    t.integer  "provider_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.index ["provider_id"], name: "index_purchases_on_provider_id", using: :btree
    t.index ["user_id"], name: "index_purchases_on_user_id", using: :btree
  end

  create_table "regions", force: :cascade do |t|
    t.string   "region_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "inicial_stock"
    t.integer  "stock_state"
    t.integer  "actual_stock"
    t.integer  "product_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["product_id"], name: "index_stocks_on_product_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "user_name"
    t.string   "user_rut"
    t.string   "user_tel"
    t.integer  "user_state",             default: 1
    t.integer  "user_range",             default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "cities", "regions"
  add_foreign_key "prices", "products"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "providers"
  add_foreign_key "providers", "cities"
  add_foreign_key "providers", "regions"
  add_foreign_key "purchase_details", "products"
  add_foreign_key "purchase_details", "purchases"
  add_foreign_key "purchases", "providers"
  add_foreign_key "stocks", "products"
end
