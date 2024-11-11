class Genre < ApplicationRecord
  has_many :book_genres
  has_many :books, through: :book_genres
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.rank_genres
    Genre.joins(:books)
         .select('genres.*, COUNT(books.id) AS book_count')
         .group('genres.id')
         .order('book_count DESC')
         .to_a
  end
end
