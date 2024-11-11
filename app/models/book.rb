# frozen_string_literal: true
class Book < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books, source: :author
  has_many :book_genres, dependent: :destroy
  has_many :genres, through: :book_genres
  has_many :wishlist_books, dependent: :destroy
  has_many :wishlists, through: :wishlist_books
  has_many :likes, dependent: :destroy
  has_many :liked_by_members, through: :likes, source: :member
  has_many :ratings, dependent: :destroy
  has_many :rated_by_members, through: :ratings, source: :member
  has_many :book_series, dependent: :destroy
  has_many :series, through: :book_series
  has_one_attached :cover_image, dependent: :destroy
  has_one :reservation
  has_many :borrowings
  has_many :borrowers, through: :borrowings, source: :borrower

  validates :isbn10, uniqueness: true, allow_blank: true, presence: true
  validates :isbn13, uniqueness: true, allow_blank: false, presence: true
  validates :title, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true }
  validates :page_count, numericality: { only_integer: true }, presence: true



  def cover_image_url
    return unless cover_image.attached?

    rails_blob_url(cover_image, only_path: true) # Use instance method to generate URL
  end

  def liked_by?(current_member)
    Like.where(book_id: id, member_id: current_member.id).exists?
  end

  def average_rating
    Rating.where(book_id: id).average(:rating)
  end

  def reserved?
    Reservation.where(book_id: id).exists?
  end

  def borrowed?
    Borrowing.where(book_id: id).exists?
  end
  
  def borrowers
    Borrowing.where(book_id: id).map { |n| Member.find(n.member_id) }
  end
end
