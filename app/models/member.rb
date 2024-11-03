class Member < ApplicationRecord
  has_many :wishlists
  has_many :ratings
  has_many :member_activities
  has_many :wishlists
  has_many :likes, dependent: :destroy
  has_many :liked_books, through: :likes, source: :book
  has_many :ratings
  has_many :rated_books, through: :ratings, source: :book
  belongs_to :role, optional: true
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
end
