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

ActiveRecord::Schema.define(version: 20181003065951) do

  create_table "stocks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trans", force: :cascade do |t|
    t.string   "source_entity_type"
    t.integer  "source_entity_id"
    t.string   "target_entity_type"
    t.integer  "target_entity_id"
    t.string   "trans_type"
    t.decimal  "amount",             precision: 10, scale: 2
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "linked_tran_id"
    t.index ["source_entity_id", "source_entity_type"], name: "index_trans_on_source_entity_id_and_source_entity_type"
    t.index ["target_entity_id", "target_entity_type"], name: "index_trans_on_target_entity_id_and_target_entity_type"
    t.index ["trans_type"], name: "index_trans_on_trans_type"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
