# frozen_string_literal: true

class WishlistBook < ApplicationRecord
  belongs_to :book
  belongs_to :wishlist
end