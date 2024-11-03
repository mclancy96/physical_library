class Like < ApplicationRecord
  belongs_to :member
  belongs_to :book

  # Validations to ensure a member can like a book only once
  validates :member_id, uniqueness: { scope: :book_id, message: "has already liked this book" }
end
