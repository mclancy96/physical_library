class ReadStatus < ApplicationRecord
  belongs_to :member
  belongs_to :book
  enum status: { unread: 0, reading: 1, completed: 2, abandoned: 3 }
end
