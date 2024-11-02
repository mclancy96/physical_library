# frozen_string_literal: true
class CreateWishlistBooksJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :wishlists, :books do |t|
      t.index %i[wishlist_id book_id], unique: true
    end
  end
end
