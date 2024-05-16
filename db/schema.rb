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

ActiveRecord::Schema[7.1].define(version: 2024_05_16_110204) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "complement"
    t.string "document_number"
    t.string "rg"
    t.string "company_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_clients_on_deleted_at"
  end

  create_table "phases", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "is_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "position"
    t.index ["deleted_at"], name: "index_phases_on_deleted_at"
    t.index ["position"], name: "index_phases_on_position"
  end

  create_table "project_files", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.binary "file_data"
    t.string "file_name"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_files_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "phase_id", null: false
    t.text "description"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_projects_on_code", unique: true
    t.index ["phase_id"], name: "index_projects_on_phase_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "type"
    t.string "name"
    t.datetime "deleted_at"
    t.boolean "is_reset_password", default: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "project_files", "projects"
  add_foreign_key "projects", "phases"
  add_foreign_key "projects", "users"
end
