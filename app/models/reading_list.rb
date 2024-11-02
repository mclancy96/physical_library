class ReadingList < ApplicationRecord
  belongs_to :member
  has_many :books
end