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

ActiveRecord::Schema.define(version: 2020_05_15_170834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "entities", force: :cascade do |t|
    t.bigint "template_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "data"
    t.datetime "published_at"
    t.string "slug"
    t.jsonb "generated_fields"
    t.bigint "user_id", null: false
    t.index ["template_id", "slug"], name: "index_entities_on_template_id_and_slug", unique: true
    t.index ["template_id"], name: "index_entities_on_template_id"
    t.index ["user_id"], name: "index_entities_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
    t.bigint "workspace_id"
    t.index ["token"], name: "index_sessions_on_token", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
    t.index ["workspace_id"], name: "index_sessions_on_workspace_id"
  end

  create_table "settings", force: :cascade do |t|
    t.integer "singleton_guard", default: 0
    t.string "name", default: "Helvellyn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "hostname"
    t.string "email", default: "from@example.com"
    t.index ["singleton_guard"], name: "index_settings_on_singleton_guard", unique: true
  end

  create_table "templates", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.jsonb "fields"
    t.string "plural"
    t.boolean "publishable", default: true
    t.string "sluggable_field"
    t.integer "entities_count"
    t.string "api_sort", default: "created_at"
    t.boolean "api_desc", default: true
    t.string "admin_sort", default: "created_at"
    t.boolean "admin_desc", default: true
    t.index ["workspace_id", "slug"], name: "index_templates_on_workspace_id_and_slug", unique: true
    t.index ["workspace_id"], name: "index_templates_on_workspace_id"
  end

  create_table "uploads", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workspace_id"], name: "index_uploads_on_workspace_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_workspaces_on_slug", unique: true
    t.index ["user_id"], name: "index_workspaces_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "entities", "templates"
  add_foreign_key "entities", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "sessions", "workspaces"
  add_foreign_key "templates", "workspaces"
  add_foreign_key "uploads", "workspaces"
  add_foreign_key "workspaces", "users"
end
