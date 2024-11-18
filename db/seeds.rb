# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
AuthorBook.destroy_all
BookGenre.destroy_all
Borrowing.destroy_all
Like.destroy_all
ReadStatus.destroy_all
Reservation.destroy_all
Book.destroy_all
Author.destroy_all
Genre.destroy_all
Member.where.not(name: 'Mike').destroy_all
Role.destroy_all

# Roles
Role.create!(name: 'Admin', code: 'admin')
member_role = Role.create!(name: 'Member', code: 'member')

# Members
alex = Member.create!(
  name: 'Alex Johnson',
  email: 'alex.johnson@example.com',
  join_date: Date.new(2023, 5, 12),
  password: 'password',
  password_confirmation: 'password',
  role_id: member_role.id
)

# Genres
fantasy = Genre.create!(name: 'Fantasy')
mystery = Genre.create!(name: 'Mystery')
Genre.create!(name: 'Science Fiction')

# Authors
author1 = Author.create!(name: 'J.K. Rowling', biography: 'British author best known for the Harry Potter series.',
                         dob: Date.new(1965, 7, 31))
author2 = Author.create!(name: 'Agatha Christie',
                         biography: 'Famous for mystery novels featuring Hercule Poirot and Miss Marple.',
                         dob: Date.new(1890, 9, 15))

# Series
hp_series = Series.create!(title: 'Harry Potter', description: "A young wizard's adventures.")
detective_series = Series.create!(title: 'Hercule Poirot Mysteries',
                                  description: 'Detective novels featuring Hercule Poirot.')

# Books
book1 = Book.create!(
  title: "Harry Potter and the Philosopher's Stone",
  publication_year: 1997,
  isbn10: '0747532699',
  isbn13: '9780747532699',
  page_count: 223
)
book2 = Book.create!(
  title: 'Murder on the Orient Express',
  publication_year: 1934,
  isbn10: '0062073508',
  isbn13: '9780062073501',
  page_count: 256
)

# AuthorBooks
AuthorBook.create!(author_id: author1.id, book_id: book1.id)
AuthorBook.create!(author_id: author2.id, book_id: book2.id)


# BookGenres
BookGenre.create!(book_id: book1.id, genre_id: fantasy.id)
BookGenre.create!(book_id: book2.id, genre_id: mystery.id)

# Borrowings
Borrowing.create!(member_id: alex.id, book_id: book1.id, borrow_date: Date.new(2024, 1, 1),
                  due_date: Date.new(2024, 1, 15), status: 'active')

# Likes
Like.create!(member_id: alex.id, book_id: book2.id)


# ReadStatuses
ReadStatus.create!(member_id: alex.id, book_id: book2.id, status: 1,
                   finished_date: Date.new(2024, 3, 15),
                   last_page_read: 200)


puts 'Seed data created successfully!'
