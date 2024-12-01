class DropWishlists < ActiveRecord::Migration[7.1]
  def change
    drop_table :wishlist_books, if_exists: true
    drop_table :wishlists, if_exists: true
  end
end
