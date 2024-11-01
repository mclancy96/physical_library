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

ActiveRecord::Schema[7.1].define(version: 2024_11_01_180819) do
  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.text "biography"
    t.datetime "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "availability_calendars", force: :cascade do |t|
    t.integer "book_id", null: false
    t.date "available_date"
    t.integer "reservation_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_availability_calendars_on_book_id"
  end

  create_table "book_copies", force: :cascade do |t|
    t.integer "book_id", null: false
    t.string "barcode"
    t.string "condition"
    t.date "acquisition_date"
    t.string "shelf_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_copies_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.integer "author_id"
    t.integer "genre_id"
    t.date "publication_date"
    t.string "isbn10"
    t.string "isbn13"
    t.integer "copies_available"
    t.string "book_type"
    t.string "digital_url"
    t.string "shelf_location"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["genre_id"], name: "index_books_on_genre_id"
  end

  create_table "borrowings", force: :cascade do |t|
    t.integer "book_id_id"
    t.integer "member_id_id"
    t.date "borrow_date"
    t.date "due_date"
    t.date "return_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id_id"], name: "index_borrowings_on_book_id_id"
    t.index ["member_id_id"], name: "index_borrowings_on_member_id_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "book_id_id"
    t.integer "member_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id_id"], name: "index_likes_on_book_id_id"
    t.index ["member_id_id"], name: "index_likes_on_member_id_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.date "join_date"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "member_id", null: false
    t.string "notification_type"
    t.text "message"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_notifications_on_member_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "book_id_id"
    t.integer "member_id_id"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id_id"], name: "index_ratings_on_book_id_id"
    t.index ["member_id_id"], name: "index_ratings_on_member_id_id"
  end

  create_table "read_statuses", force: :cascade do |t|
    t.integer "book_id_id"
    t.integer "member_id_id"
    t.string "status"
    t.date "finished_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id_id"], name: "index_read_statuses_on_book_id_id"
    t.index ["member_id_id"], name: "index_read_statuses_on_member_id_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "member_id", null: false
    t.date "reservation_date"
    t.date "expiration_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reservations_on_book_id"
    t.index ["member_id"], name: "index_reservations_on_member_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "member_id", null: false
    t.text "review_text"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["member_id"], name: "index_reviews_on_member_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "book_id"
    t.string "request_status"
    t.date "added_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_wishlists_on_book_id"
    t.index ["member_id"], name: "index_wishlists_on_member_id"
  end

  add_foreign_key "availability_calendars", "books"
  add_foreign_key "book_copies", "books"
  add_foreign_key "books", "authors"
  add_foreign_key "books", "genres"
  add_foreign_key "borrowings", "book_ids"
  add_foreign_key "borrowings", "member_ids"
  add_foreign_key "likes", "book_ids"
  add_foreign_key "likes", "member_ids"
  add_foreign_key "notifications", "members"
  add_foreign_key "ratings", "book_ids"
  add_foreign_key "ratings", "member_ids"
  add_foreign_key "read_statuses", "book_ids"
  add_foreign_key "read_statuses", "member_ids"
  add_foreign_key "reservations", "books"
  add_foreign_key "reservations", "members"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "members"
  add_foreign_key "wishlists", "books"
  add_foreign_key "wishlists", "members"
end
