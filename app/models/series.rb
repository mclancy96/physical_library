# frozen_string_literal: true

class Series < ApplicationRecord
  has_many :book_series
  has_many :books, through: :book_series
end
