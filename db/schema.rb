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

ActiveRecord::Schema.define(version: 20170117024422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.string   "isbn"
    t.string   "barcode"
    t.string   "author_1"
    t.string   "author_2"
    t.string   "author_3"
    t.string   "publisher"
    t.string   "series"
    t.string   "volume"
    t.string   "country"
    t.string   "condition"
    t.string   "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image_url"
  end

  create_table "books_categories", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["book_id"], name: "index_books_categories_on_book_id", using: :btree
    t.index ["category_id"], name: "index_books_categories_on_category_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.date     "loan_date"
    t.date     "return_date"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "is_extended",        default: false
    t.boolean  "has_returned",       default: false
    t.date     "actual_return_date"
    t.string   "fine_amount"
    t.index ["book_id"], name: "index_loans_on_book_id", using: :btree
    t.index ["user_id"], name: "index_loans_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "ic"
    t.string   "member_id"
    t.string   "email"
    t.string   "phone"
    t.date     "birthday"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
    t.string   "user_type"
    t.string   "chinese_name"
    t.string   "line1"
    t.string   "line2"
    t.string   "line3"
    t.string   "postcode"
    t.string   "city"
    t.string   "state"
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

end
