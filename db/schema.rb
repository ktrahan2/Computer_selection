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

ActiveRecord::Schema.define(version: 2020_08_18_154658) do

  create_table "computers", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.decimal "price"
    t.string "function"
    t.string "dimensions"
    t.string "status"
    t.string "warranty"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "email"
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer "computer_id"
    t.integer "customer_id"
    t.integer "number"
    t.index ["computer_id"], name: "index_recommendations_on_computer_id"
    t.index ["customer_id"], name: "index_recommendations_on_customer_id"
  end

end
