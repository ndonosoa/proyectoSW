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

ActiveRecord::Schema.define(version: 20170225125556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "name_brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name_category"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "comunas", force: :cascade do |t|
    t.string   "nombre_comuna"
    t.integer  "region_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["region_id"], name: "index_comunas_on_region_id", using: :btree
  end

  create_table "product_providers", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "provider_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["product_id"], name: "index_product_providers_on_product_id", using: :btree
    t.index ["provider_id"], name: "index_product_providers_on_provider_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name_product"
    t.integer  "brand_id"
    t.integer  "category_id"
    t.integer  "provider_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "code_product"
    t.integer  "price_product"
    t.index ["brand_id"], name: "index_products_on_brand_id", using: :btree
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["provider_id"], name: "index_products_on_provider_id", using: :btree
  end

  create_table "providers", force: :cascade do |t|
    t.string   "rut_provider"
    t.string   "name_provider"
    t.string   "phone_provider"
    t.string   "email_provider"
    t.integer  "state_provider"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "comuna_id"
    t.index ["comuna_id"], name: "index_providers_on_comuna_id", using: :btree
  end

  create_table "purchase_details", force: :cascade do |t|
    t.integer  "quantity_product"
    t.integer  "price_purchase_detail"
    t.integer  "purchase_id"
    t.integer  "product_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["product_id"], name: "index_purchase_details_on_product_id", using: :btree
    t.index ["purchase_id"], name: "index_purchase_details_on_purchase_id", using: :btree
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "total_purchase"
    t.integer  "provider_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["provider_id"], name: "index_purchases_on_provider_id", using: :btree
    t.index ["user_id"], name: "index_purchases_on_user_id", using: :btree
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name_region"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "odeplan_region"
  end

  create_table "stock_histories", force: :cascade do |t|
    t.integer  "price_stock_history"
    t.integer  "quantity_stock_history"
    t.integer  "product_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["product_id"], name: "index_stock_histories_on_product_id", using: :btree
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "quantity_stock"
    t.integer  "price_stock"
    t.integer  "product_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["product_id"], name: "index_stocks_on_product_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name_user"
    t.string   "rut_user"
    t.string   "email_user"
    t.string   "password_user"
    t.integer  "state_user"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "type_user"
  end

  add_foreign_key "comunas", "regions"
  add_foreign_key "product_providers", "products"
  add_foreign_key "product_providers", "providers"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "providers"
  add_foreign_key "providers", "comunas"
  add_foreign_key "purchase_details", "products"
  add_foreign_key "purchase_details", "purchases"
  add_foreign_key "purchases", "providers"
  add_foreign_key "purchases", "users"
  add_foreign_key "stock_histories", "products"
  add_foreign_key "stocks", "products"
end
