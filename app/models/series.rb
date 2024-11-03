# frozen_string_literal: true

class Series < ApplicationRecord
  has_many :book_series
  has_many :books, through: :book_series

  belongs_to :author, optional: true

  # Validations
  validates :title, presence: true
  validates :description, length: { maximum: 500 }
end
