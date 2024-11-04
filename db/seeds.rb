shlistBook.destroy_all
AuthorBook.destroy_all
BookGenre.destroy_all
BookSeries.destroy_all
Borrowing.destroy_all
Like.destroy_all
Notification.destroy_all
Rating.destroy_all
ReadStatus.destroy_all
Reservation.destroy_all
Review.destroy_all
Wishlist.destroy_all
BookCopy.destroy_all
Book.destroy_all
Author.destroy_all
Genre.destroy_all
Series.destroy_all
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

# BookSeries
BookSeries.create!(book_id: book1.id, series_id: hp_series.id)
BookSeries.create!(book_id: book2.id, series_id: detective_series.id)

# BookGenres
BookGenre.create!(book_id: book1.id, genre_id: fantasy.id)
BookGenre.create!(book_id: book2.id, genre_id: mystery.id)

# BookCopies
BookCopy.create!(book_id: book1.id, barcode: '12345', condition: 'Good',
                 acquisition_date: Date.new(2020, 1, 15),
                 shelf_location: 'A1')
BookCopy.create!(book_id: book2.id, barcode: '67890', condition: 'Fair',
                 acquisition_date: Date.new(2019, 6, 23),
                 shelf_location: 'B3')

# Borrowings
Borrowing.create!(member_id: alex.id, book_id: book1.id, borrow_date: Date.new(2024, 1, 1),
                  due_date: Date.new(2024, 1, 15), status: 'active')

# Likes
Like.create!(member_id: alex.id, book_id: book2.id)

# Notifications
Notification.create!(member_id: alex.id, notification_type: 'reminder', message: 'Your book is due soon!', read: false)

# Ratings
Rating.create!(member_id: alex.id, book_id: book1.id, rating: 5)

# ReadStatuses
ReadStatus.create!(member_id: alex.id, book_id: book2.id, status: 1,
                   finished_date: Date.new(2024, 3, 15),
                   last_page_read: 200)

# Reservations
Reservation.create!(member_id: alex.id, book_id: book1.id, reservation_date: Date.new(2024, 1, 5),
                    expiration_date: Date.new(2024, 1, 10), status: 'reserved')

# Reviews
Review.create!(member_id: alex.id, book_id: book1.id, review_text: 'An absolute classic!')

# Wishlist
wishlist = Wishlist.create!(member_id: alex.id, book_id: book2.id, title: 'Must Reads', request_status: 'pending',
                            added_date: Date.new(2024, 1, 20))
WishlistBook.create!(wishlist_id: wishlist.id, book_id: book2.id)

puts 'Seed data created successfully!'