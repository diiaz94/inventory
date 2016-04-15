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

ActiveRecord::Schema.define(version: 20160413213249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.integer  "profile_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commerces", ["profile_id"], name: "index_commerces_on_profile_id", using: :btree

  create_table "deposits", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "products", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "category_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "users", force: true do |t|
    t.string   "cedula",           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["cedula"], name: "index_users_on_cedula", unique: true, using: :btree

end
