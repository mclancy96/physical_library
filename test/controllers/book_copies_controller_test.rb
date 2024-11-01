require "test_helper"

class BookCopiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_copy = book_copies(:one)
  end

  test "should get index" do
    get book_copies_url
    assert_response :success
  end

  test "should get new" do
    get new_book_copy_url
    assert_response :success
  end

  test "should create book_copy" do
    assert_difference("BookCopy.count") do
      post book_copies_url, params: { book_copy: { acquisition_date: @book_copy.acquisition_date, barcode: @book_copy.barcode, book_id: @book_copy.book_id, condition: @book_copy.condition, shelf_location: @book_copy.shelf_location } }
    end

    assert_redirected_to book_copy_url(BookCopy.last)
  end

  test "should show book_copy" do
    get book_copy_url(@book_copy)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_copy_url(@book_copy)
    assert_response :success
  end

  test "should update book_copy" do
    patch book_copy_url(@book_copy), params: { book_copy: { acquisition_date: @book_copy.acquisition_date, barcode: @book_copy.barcode, book_id: @book_copy.book_id, condition: @book_copy.condition, shelf_location: @book_copy.shelf_location } }
    assert_redirected_to book_copy_url(@book_copy)
  end

  test "should destroy book_copy" do
    assert_difference("BookCopy.count", -1) do
      delete book_copy_url(@book_copy)
    end

    assert_redirected_to book_copies_url
  end
end
