class Borrowing < ApplicationRecord
  belongs_to :book
  belongs_to :borrower, class_name: 'Member', foreign_key: 'member_id'
end
