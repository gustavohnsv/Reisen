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

ActiveRecord::Schema[8.1].define(version: 2025_10_27_210025) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "checklist_items", force: :cascade do |t|
    t.boolean "check", default: false, null: false
    t.integer "checklist_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "updated_at", null: false
    t.index ["checklist_id"], name: "index_checklist_items_on_checklist_id"
  end

  create_table "checklists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_checklists_on_user_id"
  end

  create_table "notices", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "visible", default: false, null: false
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "permission"
    t.integer "script_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["script_id"], name: "index_participants_on_script_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "script_comments", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "script_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["script_id"], name: "index_script_comments_on_script_id"
    t.index ["user_id"], name: "index_script_comments_on_user_id"
  end

  create_table "script_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "date_time_start"
    t.string "description"
    t.decimal "estimated_cost", precision: 10, scale: 2
    t.string "location"
    t.integer "script_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["script_id"], name: "index_script_items_on_script_id"
    t.index ["user_id"], name: "index_script_items_on_user_id"
  end

  create_table "script_spents", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.integer "script_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["script_id"], name: "index_script_spents_on_script_id"
    t.index ["user_id"], name: "index_script_spents_on_user_id"
  end

  create_table "scripts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "shareable_token"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["shareable_token"], name: "index_scripts_on_shareable_token", unique: true
    t.index ["user_id"], name: "index_scripts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "unconfirmed_email"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "checklist_items", "checklists"
  add_foreign_key "checklists", "users"
  add_foreign_key "notices", "users"
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
