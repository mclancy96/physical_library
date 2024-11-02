class Wishlist < ApplicationRecord
  belongs_to :member
  has_many :books, through: :books_wishlists, dependent: :destroy
end
