# frozen_string_literal: true
class BookCopy < ApplicationRecord
  belongs_to :book

  # Validations
  validates :barcode, presence: true, uniqueness: true
  validates :condition, inclusion: { in: %w[New Good Fair Poor] }
  validates :shelf_location, presence: true

  # Optionally, you can add a method to represent the book copy in a more readable format
  def to_s
    "#{book.title} - #{condition} (Barcode: #{barcode})"
  end
end
