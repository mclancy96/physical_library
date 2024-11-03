# frozen_string_literal: true
class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  has_many :wishlist_books
  has_many :wishlists, through: :wishlist_books
  has_many :likes
  has_many :liked_by_members, through: :likes, source: :member
  has_many :ratings
  has_many :rated_by_members, through: :ratings, source: :member
  has_many :book_series
  has_many :series, through: :book_series
  has_many :reading_lists
  has_many :members, through: :reading_lists
end
