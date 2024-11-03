class ReadingList < ApplicationRecord
  belongs_to :member
  belongs_to :book
end