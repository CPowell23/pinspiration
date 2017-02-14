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

ActiveRecord::Schema.define(version: 20170214220848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.text     "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_admins_on_username", unique: true, using: :btree
  end

  create_table "boards", force: :cascade do |t|
    t.boolean  "private"
    t.string   "name"
    t.text     "description"
    t.integer  "registered_user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "index_boards_on_category_id", using: :btree
    t.index ["registered_user_id"], name: "index_boards_on_registered_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "registered_user_id"
    t.integer  "pin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["pin_id"], name: "index_comments_on_pin_id", using: :btree
    t.index ["registered_user_id"], name: "index_comments_on_registered_user_id", using: :btree
  end

  create_table "developer_credentials", force: :cascade do |t|
    t.integer  "registered_user_id"
    t.string   "api_key"
    t.string   "project_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["registered_user_id"], name: "index_developer_credentials_on_registered_user_id", using: :btree
  end

  create_table "follow_joins", force: :cascade do |t|
    t.integer  "registered_user_id"
    t.integer  "follower_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["registered_user_id"], name: "index_follow_joins_on_registered_user_id", using: :btree
  end

  create_table "google_credentials", force: :cascade do |t|
    t.string   "google_uid"
    t.string   "name"
    t.string   "username"
    t.string   "phone_number"
    t.integer  "registered_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image_url"
    t.string   "email"
    t.index ["google_uid"], name: "index_google_credentials_on_google_uid", unique: true, using: :btree
    t.index ["registered_user_id"], name: "index_google_credentials_on_registered_user_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "registered_user_id"
    t.string   "target_type"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["registered_user_id"], name: "index_likes_on_registered_user_id", using: :btree
    t.index ["target_type", "target_id"], name: "index_likes_on_target_type_and_target_id", using: :btree
  end

  create_table "pins", force: :cascade do |t|
    t.text     "description"
    t.text     "image_url"
    t.text     "article_url"
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["board_id"], name: "index_pins_on_board_id", using: :btree
  end

  create_table "pinspiration_credentials", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.text     "password_digest"
    t.string   "phone_number"
    t.integer  "registered_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image_url"
    t.index ["email"], name: "index_pinspiration_credentials_on_email", unique: true, using: :btree
    t.index ["registered_user_id"], name: "index_pinspiration_credentials_on_registered_user_id", using: :btree
    t.index ["username"], name: "index_pinspiration_credentials_on_username", unique: true, using: :btree
  end

  create_table "registered_users", force: :cascade do |t|
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "developer_credentials", "registered_users"
end
