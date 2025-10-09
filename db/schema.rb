# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_10_09_194747) do
  create_table "checklist_items", force: :cascade do |t|
    t.text "description"
    t.integer "user_id", null: false
    t.integer "checklist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checklist_id"], name: "index_checklist_items_on_checklist_id"
    t.index ["user_id"], name: "index_checklist_items_on_user_id"
  end

  create_table "checklists", force: :cascade do |t|
    t.string "title"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_checklists_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "permission"
    t.integer "user_id", null: false
    t.integer "script_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["script_id"], name: "index_participants_on_script_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "script_comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.integer "script_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["script_id"], name: "index_script_comments_on_script_id"
    t.index ["user_id"], name: "index_script_comments_on_user_id"
  end

  create_table "script_items", force: :cascade do |t|
    t.string "title"
    t.integer "user_id", null: false
    t.integer "script_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["script_id"], name: "index_script_items_on_script_id"
    t.index ["user_id"], name: "index_script_items_on_user_id"
  end

  create_table "script_spents", force: :cascade do |t|
    t.decimal "amount"
    t.integer "user_id", null: false
    t.integer "script_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["script_id"], name: "index_script_spents_on_script_id"
    t.index ["user_id"], name: "index_script_spents_on_user_id"
  end

  create_table "scripts", force: :cascade do |t|
    t.string "title"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_scripts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "checklist_items", "checklists"
  add_foreign_key "checklist_items", "users"
  add_foreign_key "checklists", "users"
  add_foreign_key "participants", "scripts"
  add_foreign_key "participants", "users"
  add_foreign_key "script_comments", "scripts"
  add_foreign_key "script_comments", "users"
  add_foreign_key "script_items", "scripts"
  add_foreign_key "script_items", "users"
  add_foreign_key "script_spents", "scripts"
  add_foreign_key "script_spents", "users"
  add_foreign_key "scripts", "users"
end
