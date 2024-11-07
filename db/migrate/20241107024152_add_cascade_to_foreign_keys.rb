class AddCascadeToForeignKeys < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :author_books, :books
    add_foreign_key :author_books, :books, on_delete: :cascade

    remove_foreign_key :book_genres, :books
    add_foreign_key :book_genres, :books, on_delete: :cascade

    remove_foreign_key :book_series, :books
    add_foreign_key :book_series, :books, on_delete: :cascade

    remove_foreign_key :borrowings, :books
    add_foreign_key :borrowings, :books, on_delete: :cascade

    remove_foreign_key :likes, :books
    add_foreign_key :likes, :books, on_delete: :cascade

    remove_foreign_key :ratings, :books
    add_foreign_key :ratings, :books, on_delete: :cascade

    remove_foreign_key :read_statuses, :books
    add_foreign_key :read_statuses, :books, on_delete: :cascade

    remove_foreign_key :reservations, :books
    add_foreign_key :reservations, :books, on_delete: :cascade

    remove_foreign_key :reviews, :books
    add_foreign_key :reviews, :books, on_delete: :cascade

    add_foreign_key :wishlist_books, :books, on_delete: :cascade
    add_foreign_key :wishlist_books, :wishlists, on_delete: :cascade
  end
end
