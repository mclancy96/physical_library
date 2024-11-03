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
BookCopy.destroy_all
Reservation.destroy_all
Borrowing.destroy_all
Like.destroy_all
Rating.destroy_all
Review.destroy_all
ReadStatus.destroy_all
Wishlist.destroy_all
MemberActivity.destroy_all
Notification.destroy_all

# Then, destroy records from the members table
Member.where.not(name: 'Mike').destroy_all
# Next, clear the books and their related data
Book.destroy_all

# Finally, clear authors and genres
Author.destroy_all
Genre.destroy_all
Role.destroy_all

# Create Roles
admin_role = Role.create(name: 'Admin', code: 'admin')
user_role = Role.create(name: 'User', code: 'user')
guest_role = Role.create(name: 'Guest', code: 'guest')

# Create Members
members = [
  { name: 'Alice Smith', email: 'alice@example.com', join_date: Date.today, password: 'password123', role: user_role },
  { name: 'Bob Johnson', email: 'bob@example.com', join_date: Date.today, password: 'password123', role: admin_role },
  { name: 'Charlie Brown', email: 'charlie@example.com', join_date: Date.today, password: 'password123',
    role: guest_role },
]

members.each do |member_data|
  Member.create(member_data)
end

# Create Authors

Author.create(name: 'George Orwell', biography: 'English novelist and essayist', dob: '1903-06-25')
Author.create(name: 'J.K. Rowling', biography: 'British author, best known for the Harry Potter series',
              dob: '1965-07-31')
Author.create(name: 'F. Scott Fitzgerald', biography: 'American novelist and short story writer', dob: '1896-09-24')

# Create Genres

Genre.create(name: 'Fiction')
Genre.create(name: 'Fantasy')
Genre.create(name: 'Classic')
Genre.create(name: 'Science Fiction')

# Create Books using the created Authors and Genres
books = [
  { title: '1984', author: Author.where(name: 'George Orwell').first, genre: Genre.where(name: 'Science Fiction').first, publication_date: '1949-06-08',
    isbn10: '0451524934', isbn13: '978-0451524935', copies_available: 5, book_type: 'physical' },
  { title: 'Harry Potter and the Sorcerer\'s Stone', author: Author.where(name: 'J.K. Rowling').first,
    genre: Genre.where(name: 'Fantasy').first, publication_date: '1997-06-26', isbn10: '0439708184', isbn13: '978-0439708180', copies_available: 3, book_type: 'physical' },
  { title: 'The Great Gatsby', author: Author.where(name: 'F. Scott Fitzgerald').first, genre: Genre.where(name: 'Classic').first,
    publication_date: '1925-04-10', isbn10: '0743273567', isbn13: '978-0743273565', copies_available: 4, book_type: 'physical' },
]

books.each do |book_data|
  Book.create(book_data)
end

# Create Book Copies
book_copies = [
  { book: Book.where(title: '1984').first, barcode: '1234567890', condition: 'Good', acquisition_date: Date.today, shelf_location: 'A1' },
  { book: Book.where(isbn10: '0439708184').first, barcode: '0987654321', condition: 'New', acquisition_date: Date.today, shelf_location: 'B2' },
  { book: Book.where(isbn10: '0743273567').first, barcode: '1122334455', condition: 'Fair', acquisition_date: Date.today, shelf_location: 'C3' },
]

book_copies.each do |copy_data|
  BookCopy.create(copy_data)
end

# Create Wishlists
wishlists = [
  { member: Member.first, book_id: Book.where(title: '1984').first&.id, request_status: 'Pending', added_date: Date.today },
  { member: Member.first, book_id: Book.where(isbn10: '0439708184').first&.id, request_status: 'Approved', added_date: Date.today },
  { member: Member.last, book_id: Book.where(isbn10: '0439708184').first&.id, request_status: 'Rejected', added_date: Date.today },
]

wishlists.each do |wishlist_data|
  Wishlist.create(wishlist_data)
end

# Create Reservations
reservations = [
  { member: Member.first, book_id: Book.where(title: '1984').first&.id, reservation_date: Date.today, expiration_date: Date.today + 7.days,
    status: 'Active' },
  { member: Member.last, book_id: Book.where(isbn10: '0439708184').first&.id, reservation_date: Date.today, expiration_date: Date.today + 14.days,
    status: 'Active' },
]

reservations.each do |reservation_data|
  Reservation.create(reservation_data)
end

# Create Reviews
reviews = [
  { member: Member.first, book_id: Book.where(title: '1984').first&.id, review_text: 'A chilling dystopian novel.', rating: 5 },
  { member: Member.first, book_id: Book.where(isbn10: '0439708184').first&.id, review_text: 'A magical adventure for all ages.', rating: 4 },
]

reviews.each do |review_data|
  Review.create(review_data)
end

# Create Ratings
ratings = [
  { member: Member.first, book_id: Book.where(title: '1984').first&.id, rating: 5 },
  { member: Member.second, book_id: Book.where(isbn10: '0439708184').first&.id, rating: 4 },
]

ratings.each do |rating_data|
  Rating.create(rating_data)
end

# Create Borrowings
borrowings = [
  { member: Member.first, book_id: Book.where(title: '1984').first&.id, borrow_date: Date.today, due_date: Date.today + 30.days, return_date: nil,
    status: 'Borrowed' },
]

borrowings.each do |borrowing_data|
  Borrowing.create(borrowing_data)
end

puts "Seed data created successfully!"
