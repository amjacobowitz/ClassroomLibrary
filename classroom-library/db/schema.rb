# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150729155709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_authors", force: true do |t|
    t.integer  "student_id"
    t.integer  "author_id"
    t.boolean  "favorite",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_genres", force: true do |t|
    t.integer  "student_id"
    t.integer  "genre_id"
    t.boolean  "favorite",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: true do |t|
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "grouping"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klasses", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "klass_number"
    t.integer  "school_year"
    t.integer  "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", force: true do |t|
    t.string   "content"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_texts", force: true do |t|
    t.integer  "student_id"
    t.integer  "text_id"
    t.integer  "rating"
    t.boolean  "favorite",              default: false
    t.boolean  "checked_out",           default: false
    t.boolean  "completed",             default: false
    t.boolean  "abandoned",             default: false
    t.string   "reason_for_abandoning", default: ""
    t.string   "review_title",          default: ""
    t.string   "review_content",        default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password"
    t.string   "handle"
    t.integer  "klass_number"
    t.integer  "lexile_level"
    t.integer  "klass_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.string   "prefix"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "texts", force: true do |t|
    t.integer  "isbn"
    t.integer  "lexile_level"
    t.integer  "pages"
    t.string   "title"
    t.string   "author"
    t.string   "genre"
    t.string   "classroom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
