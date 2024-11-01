require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "Books"
  end

  test "should create book" do
    visit books_url
    click_on "New book"

    fill_in "Author", with: @book.author_id
    fill_in "Book type", with: @book.book_type
    fill_in "Copies available", with: @book.copies_available
    fill_in "Digital url", with: @book.digital_url
    fill_in "Genre", with: @book.genre_id
    fill_in "Isbn10", with: @book.isbn10
    fill_in "Isbn13", with: @book.isbn13
    fill_in "Publication date", with: @book.publication_date
    fill_in "Shelf location", with: @book.shelf_location
    fill_in "Status", with: @book.status
    fill_in "Title", with: @book.title
    click_on "Create Book"

    assert_text "Book was successfully created"
    click_on "Back"
  end

  test "should update Book" do
    visit book_url(@book)
    click_on "Edit this book", match: :first

    fill_in "Author", with: @book.author_id
    fill_in "Book type", with: @book.book_type
    fill_in "Copies available", with: @book.copies_available
    fill_in "Digital url", with: @book.digital_url
    fill_in "Genre", with: @book.genre_id
    fill_in "Isbn10", with: @book.isbn10
    fill_in "Isbn13", with: @book.isbn13
    fill_in "Publication date", with: @book.publication_date
    fill_in "Shelf location", with: @book.shelf_location
    fill_in "Status", with: @book.status
    fill_in "Title", with: @book.title
    click_on "Update Book"

    assert_text "Book was successfully updated"
    click_on "Back"
  end

  test "should destroy Book" do
    visit book_url(@book)
    click_on "Destroy this book", match: :first

    assert_text "Book was successfully destroyed"
  end
end
