class ReadStatus < ApplicationRecord
  belongs_to :member
  enum status: { unread: 0, reading: 1, completed: 2, abandoned: 3 }
end
