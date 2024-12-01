# frozen_string_literal: true
#
class Author < ApplicationRecord
  has_many :author_books
  has_many :books, through: :author_books
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
