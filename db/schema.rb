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

ActiveRecord::Schema[7.1].define(version: 2024_11_21_013456) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "author_books", force: :cascade do |t|
    t.integer "author_id", null: false
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_author_books_on_author_id"
    t.index ["book_id"], name: "index_author_books_on_book_id"
  end

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.text "biography"
    t.datetime "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_authors_on_name", unique: true
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

  create_table "book_genres", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_genres_on_book_id"
    t.index ["genre_id"], name: "index_book_genres_on_genre_id"
  end

  create_table "book_series", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "book_id", null: false
    t.integer "series_id", null: false
    t.index ["book_id", "series_id"], name: "index_book_series_on_book_id_and_series_id", unique: true
    t.index ["book_id"], name: "index_book_series_on_book_id"
    t.index ["series_id"], name: "index_book_series_on_series_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.integer "publication_year"
    t.string "isbn10"
    t.string "isbn13"
    t.integer "page_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shelf_location"
    t.bigint "dewey_code_id"
    t.index ["dewey_code_id"], name: "index_books_on_dewey_code_id"
    t.index ["isbn10"], name: "index_books_on_isbn10", unique: true, where: "isbn10 IS NOT NULL"
    t.index ["isbn13"], name: "index_books_on_isbn13", unique: true, where: "isbn13 IS NOT NULL"
  end

  create_table "borrowings", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "book_id", null: false
    t.date "borrow_date", null: false
    t.date "due_date", null: false
    t.date "return_date"
    t.string "status", default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_borrowings_on_book_id"
    t.index ["member_id"], name: "index_borrowings_on_member_id"
  end

  create_table "dewey_codes", force: :cascade do |t|
    t.integer "level"
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level", "code"], name: "index_dewey_codes_on_level_and_code", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_likes_on_book_id"
    t.index ["member_id", "book_id"], name: "index_likes_on_member_id_and_book_id", unique: true
    t.index ["member_id"], name: "index_likes_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.date "join_date", null: false
    t.string "password_digest", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_members_on_role_id"
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
    t.integer "book_id", null: false
    t.integer "member_id", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_ratings_on_book_id"
    t.index ["member_id"], name: "index_ratings_on_member_id"
  end

  create_table "read_statuses", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "book_id", null: false
    t.integer "status", default: 1
    t.date "finished_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "last_page_read"
    t.index ["book_id"], name: "index_read_statuses_on_book_id"
    t.index ["member_id"], name: "index_read_statuses_on_member_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "member_id", null: false
    t.date "reservation_date", null: false
    t.date "expiration_date", null: false
    t.string "status", default: "0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reservations_on_book_id"
    t.index ["member_id"], name: "index_reservations_on_member_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "member_id", null: false
    t.text "review_text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["member_id"], name: "index_reviews_on_member_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "series", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "title", null: false
    t.text "description"
  end

  create_table "wishlist_books", id: false, force: :cascade do |t|
    t.integer "wishlist_id", null: false
    t.integer "book_id", null: false
    t.index ["wishlist_id", "book_id"], name: "index_wishlist_books_on_wishlist_id_and_book_id", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "book_id", null: false
    t.string "title", null: false
    t.string "request_status", default: "0"
    t.date "added_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_wishlists_on_book_id"
    t.index ["member_id"], name: "index_wishlists_on_member_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "author_books", "authors"
  add_foreign_key "author_books", "books", on_delete: :cascade
  add_foreign_key "book_copies", "books"
  add_foreign_key "book_genres", "books", on_delete: :cascade
  add_foreign_key "book_genres", "genres"
  add_foreign_key "book_series", "books", on_delete: :cascade
  add_foreign_key "book_series", "series"
  add_foreign_key "books", "dewey_codes"
  add_foreign_key "borrowings", "books", on_delete: :cascade
  add_foreign_key "borrowings", "members"
  add_foreign_key "likes", "books", on_delete: :cascade
  add_foreign_key "likes", "members"
  add_foreign_key "notifications", "members"
  add_foreign_key "ratings", "books", on_delete: :cascade
  add_foreign_key "ratings", "members"
  add_foreign_key "read_statuses", "books", on_delete: :cascade
  add_foreign_key "read_statuses", "members"
  add_foreign_key "reservations", "books", on_delete: :cascade
  add_foreign_key "reservations", "members"
  add_foreign_key "reviews", "books", on_delete: :cascade
  add_foreign_key "reviews", "members"
  add_foreign_key "wishlist_books", "books", on_delete: :cascade
  add_foreign_key "wishlist_books", "wishlists", on_delete: :cascade
  add_foreign_key "wishlists", "books"
  add_foreign_key "wishlists", "members"
end
