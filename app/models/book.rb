# frozen_string_literal: true
class Book < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :author_books
  has_many :authors, through: :author_books
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_many :wishlist_books
  has_many :wishlists, through: :wishlist_books
  has_many :likes
  has_many :liked_by_members, through: :likes, source: :member
  has_many :ratings
  has_many :rated_by_members, through: :ratings, source: :member
  has_many :book_series
  has_many :series, through: :book_series
  has_one_attached :cover_image

  validates :isbn10, uniqueness: true, allow_blank: true
  validates :isbn13, uniqueness: true, allow_blank: true

  def cover_image_url
    return unless cover_image.attached?

      rails_blob_url(cover_image, only_path: true) # Use instance method to generate URL
  end

end
