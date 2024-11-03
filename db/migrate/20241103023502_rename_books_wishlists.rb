class RenameBooksWishlists < ActiveRecord::Migration[7.1]
  def change
    rename_table :books_wishlists, :wishlist_books
  end
end
