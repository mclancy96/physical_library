# frozen_string_literal: true
class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  belongs_to :series, optional: true
  has_many :ratings
  has_many :wishlists
  has_many :member_activities

  # For featured books
  scope :featured, -> { where(featured: true) }
end
