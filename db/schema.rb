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

ActiveRecord::Schema.define(version: 2019_05_06_031949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventory_items", force: :cascade do |t|
    t.string "input_title", null: false
    t.string "input_supplier", null: false
    t.integer "ingredient_id"
    t.integer "measurement_id"
    t.float "total_cost", null: false
    t.float "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "measurements", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipe_items", force: :cascade do |t|
    t.string "input_title"
    t.string "item_type"
    t.integer "item_id"
    t.integer "measurement_id"
    t.float "amount", null: false
    t.float "calculated_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title", null: false
    t.float "cost_of_goods"
    t.float "menu_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
