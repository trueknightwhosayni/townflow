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

ActiveRecord::Schema.define(version: 2021_06_25_184034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "at_collections", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "folder_id"
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "relation_label_field_id"
    t.string "system_class_name"
    t.index ["user_id"], name: "index_at_collections_on_user_id"
  end

  create_table "at_fields", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.string "title", null: false
    t.string "name", null: false
    t.string "field_data_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "at_folders", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "user_id"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_at_folders_on_ancestry"
    t.index ["user_id"], name: "index_at_folders_on_user_id"
  end

  create_table "at_forms", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "collection_id", null: false
    t.boolean "system", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "at_god_records", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.jsonb "anything_data", default: "{}"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_at_god_records_on_collection_id"
  end

  create_table "at_view_fields", force: :cascade do |t|
    t.bigint "view_id"
    t.bigint "field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_id"], name: "index_at_view_fields_on_field_id"
    t.index ["view_id"], name: "index_at_view_fields_on_view_id"
  end

  create_table "at_views", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.string "title", null: false
    t.integer "view_type", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "erp_section_accesses", force: :cascade do |t|
    t.bigint "section_id"
    t.bigint "group_id"
    t.bigint "role_id"
    t.string "action", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_erp_section_accesses_on_group_id"
    t.index ["role_id"], name: "index_erp_section_accesses_on_role_id"
  end

  create_table "erp_section_categories", force: :cascade do |t|
    t.string "key", null: false
    t.string "title", null: false
    t.string "ancestry"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_erp_section_categories_on_ancestry"
  end

  create_table "erp_sections", force: :cascade do |t|
    t.bigint "section_category_id"
    t.bigint "anything_collection_id"
    t.string "list_renderer_class", null: false
    t.string "list_renderer_attributes", null: false
    t.string "document_renderer_class", null: false
    t.string "document_renderer_attributes", null: false
    t.string "new_item_processor_class", null: false
    t.string "new_item_processor_attributes", null: false
    t.boolean "allow_editing", default: false
    t.boolean "allow_deleting", default: false
    t.string "key", null: false
    t.string "title", null: false
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "groups_roles", id: false, force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "role_id"
    t.index ["group_id", "role_id"], name: "index_groups_roles_on_group_id_and_role_id"
    t.index ["group_id"], name: "index_groups_roles_on_group_id"
    t.index ["role_id"], name: "index_groups_roles_on_role_id"
  end

  create_table "neewom_fields", force: :cascade do |t|
    t.integer "form_id", null: false
    t.string "label"
    t.string "name", null: false
    t.string "input"
    t.boolean "virtual"
    t.string "validations"
    t.string "collection_klass"
    t.string "collection_method"
    t.string "collection_params"
    t.string "label_method"
    t.string "value_method"
    t.string "input_html"
    t.string "custom_options"
    t.integer "order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id", "name"], name: "index_neewom_fields_on_form_id_and_name", unique: true
  end

  create_table "neewom_forms", force: :cascade do |t|
    t.string "key", null: false
    t.string "description"
    t.string "crc32", null: false
    t.string "repository_klass", null: false
    t.string "template", null: false
    t.boolean "persist_submit_controls"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crc32"], name: "index_neewom_forms_on_crc32", unique: true
    t.index ["key"], name: "index_neewom_forms_on_key", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_groups", id: false, force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.index ["group_id"], name: "index_users_groups_on_group_id"
    t.index ["user_id", "group_id"], name: "index_users_groups_on_user_id_and_group_id"
    t.index ["user_id"], name: "index_users_groups_on_user_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
