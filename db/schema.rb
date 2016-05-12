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

ActiveRecord::Schema.define(version: 20160511025117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: true do |t|
    t.float    "total"
    t.integer  "seller_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["seller_id"], name: "index_bills_on_seller_id", using: :btree

  create_table "brands", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commerces", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commerces", ["user_id"], name: "index_commerces_on_user_id", using: :btree

  create_table "deposits", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "slug"
    t.integer  "commerce_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deposits", ["commerce_id"], name: "index_deposits_on_commerce_id", using: :btree

  create_table "deposits_products", force: true do |t|
    t.integer  "cantidad"
    t.float    "precio"
    t.integer  "deposit_id"
    t.integer  "product_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deposits_products", ["deposit_id"], name: "index_deposits_products_on_deposit_id", using: :btree
  add_index "deposits_products", ["product_id"], name: "index_deposits_products_on_product_id", using: :btree

  create_table "downloads", force: true do |t|
    t.integer  "cantidad"
    t.integer  "cantidad_inicial"
    t.float    "precio"
    t.integer  "deposit_id"
    t.integer  "store_id"
    t.integer  "product_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "downloads", ["deposit_id"], name: "index_downloads_on_deposit_id", using: :btree
  add_index "downloads", ["product_id"], name: "index_downloads_on_product_id", using: :btree
  add_index "downloads", ["store_id"], name: "index_downloads_on_store_id", using: :btree

  create_table "loads", force: true do |t|
    t.integer  "cantidad"
    t.integer  "cantidad_inicial"
    t.float    "precio"
    t.integer  "deposit_id"
    t.integer  "product_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loads", ["deposit_id"], name: "index_loads_on_deposit_id", using: :btree
  add_index "loads", ["product_id"], name: "index_loads_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "category_id"
    t.integer  "unit_id"
    t.integer  "brand_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["brand_id"], name: "index_products_on_brand_id", using: :btree
  add_index "products", ["unit_id"], name: "index_products_on_unit_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "primer_nombre"
    t.string   "segundo_nombre"
    t.string   "primer_apellido"
    t.string   "segundo_apellido"
    t.boolean  "sexo"
    t.string   "email"
    t.string   "celular"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", force: true do |t|
    t.integer  "cantidad"
    t.float    "precio"
    t.integer  "bill_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sales", ["bill_id"], name: "index_sales_on_bill_id", using: :btree
  add_index "sales", ["product_id"], name: "index_sales_on_product_id", using: :btree

  create_table "sellers", force: true do |t|
    t.integer  "commerce_id"
    t.integer  "store_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sellers", ["commerce_id"], name: "index_sellers_on_commerce_id", using: :btree
  add_index "sellers", ["store_id"], name: "index_sellers_on_store_id", using: :btree

  create_table "stores", force: true do |t|
    t.string   "nombre"
    t.text     "direccion"
    t.integer  "commerce_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stores", ["commerce_id"], name: "index_stores_on_commerce_id", using: :btree

  create_table "units", force: true do |t|
    t.string   "nombre"
    t.string   "abv"
    t.text     "descripcion"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "cedula",           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "slug"
    t.integer  "role_id"
    t.integer  "seller_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["cedula"], name: "index_users_on_cedula", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree
  add_index "users", ["seller_id"], name: "index_users_on_seller_id", using: :btree

end
