class Member < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liked_books, through: :likes, source: :book
  has_many :reservations
  belongs_to :role, optional: true
  has_many :borrowings
  has_many :borrowed_books, through: :borrowings, source: :book
  has_many :read_statuses

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { minimum: 3, maximum: 25 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 3, maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true,
                       length: { minimum: 6 }
  validates :password_confirmation, presence: true,
                                    length: { minimum: 6 }

  has_secure_password

  def reservation_count
    reservations.where(member_id: id).count
  end

  def borrowing_count
    borrowings.where(member_id: id).count
  end

  def like_count
    likes.where(member_id: id).count
  end
end
