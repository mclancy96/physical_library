require "application_system_test_case"

class WishlistsTest < ApplicationSystemTestCase
  setup do
    @wishlist = wishlists(:one)
  end

  test "visiting the index" do
    visit wishlists_url
    assert_selector "h1", text: "Wishlists"
  end

  test "should create wishlist" do
    visit wishlists_url
    click_on "New wishlist"

    fill_in "Added date", with: @wishlist.added_date
    fill_in "Author", with: @wishlist.author
    fill_in "Book", with: @wishlist.book_id
    fill_in "Genre", with: @wishlist.genre_id
    fill_in "Isbn", with: @wishlist.isbn
    fill_in "Library response", with: @wishlist.library_response
    fill_in "Member", with: @wishlist.member_id
    fill_in "Publication date", with: @wishlist.publication_date
    fill_in "Request status", with: @wishlist.request_status
    fill_in "Title", with: @wishlist.title
    click_on "Create Wishlist"

    assert_text "Wishlist was successfully created"
    click_on "Back"
  end

  test "should update Wishlist" do
    visit wishlist_url(@wishlist)
    click_on "Edit this wishlist", match: :first

    fill_in "Added date", with: @wishlist.added_date
    fill_in "Author", with: @wishlist.author
    fill_in "Book", with: @wishlist.book_id
    fill_in "Genre", with: @wishlist.genre_id
    fill_in "Isbn", with: @wishlist.isbn
    fill_in "Library response", with: @wishlist.library_response
    fill_in "Member", with: @wishlist.member_id
    fill_in "Publication date", with: @wishlist.publication_date
    fill_in "Request status", with: @wishlist.request_status
    fill_in "Title", with: @wishlist.title
    click_on "Update Wishlist"

    assert_text "Wishlist was successfully updated"
    click_on "Back"
  end

  test "should destroy Wishlist" do
    visit wishlist_url(@wishlist)
    click_on "Destroy this wishlist", match: :first

    assert_text "Wishlist was successfully destroyed"
  end
end
