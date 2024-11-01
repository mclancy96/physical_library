require "application_system_test_case"

class ReviewsTest < ApplicationSystemTestCase
  setup do
    @review = reviews(:one)
  end

  test "visiting the index" do
    visit reviews_url
    assert_selector "h1", text: "Reviews"
  end

  test "should create review" do
    visit reviews_url
    click_on "New review"

    fill_in "Book", with: @review.book_id
    fill_in "Created at", with: @review.created_at
    fill_in "Member", with: @review.member_id
    fill_in "Rating", with: @review.rating
    fill_in "Review text", with: @review.review_text
    click_on "Create Review"

    assert_text "Review was successfully created"
    click_on "Back"
  end

  test "should update Review" do
    visit review_url(@review)
    click_on "Edit this review", match: :first

    fill_in "Book", with: @review.book_id
    fill_in "Created at", with: @review.created_at
    fill_in "Member", with: @review.member_id
    fill_in "Rating", with: @review.rating
    fill_in "Review text", with: @review.review_text
    click_on "Update Review"

    assert_text "Review was successfully updated"
    click_on "Back"
  end

  test "should destroy Review" do
    visit review_url(@review)
    click_on "Destroy this review", match: :first

    assert_text "Review was successfully destroyed"
  end
end
