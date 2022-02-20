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

ActiveRecord::Schema.define(version: 2022_02_19_191007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.text "title"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "public", null: false
    t.text "type", default: "Article::Post", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "commenter"
    t.text "body"
    t.bigint "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "public", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "intervals", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.datetime "start_at", precision: 6
    t.datetime "end_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_intervals_on_task_id"
  end

  create_table "tags", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "name"], name: "index_tags_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "title", null: false
    t.text "description"
    t.bigint "parent_id"
    t.datetime "desired_at", precision: 6
    t.datetime "deadline", precision: 6
    t.datetime "completed", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_tasks_on_parent_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "tasks_tags", id: false, force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "tag_id"
    t.index ["tag_id"], name: "index_tasks_tags_on_tag_id"
    t.index ["task_id"], name: "index_tasks_tags_on_task_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "nickname", null: false
    t.text "email", null: false
    t.text "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

  add_foreign_key "comments", "articles"
  add_foreign_key "intervals", "tasks"
  add_foreign_key "tags", "users"
  add_foreign_key "tasks", "tasks", column: "parent_id"
  add_foreign_key "tasks", "users"
end
