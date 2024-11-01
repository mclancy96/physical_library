require "application_system_test_case"

class ReadStatusesTest < ApplicationSystemTestCase
  setup do
    @read_status = read_statuses(:one)
  end

  test "visiting the index" do
    visit read_statuses_url
    assert_selector "h1", text: "Read statuses"
  end

  test "should create read status" do
    visit read_statuses_url
    click_on "New read status"

    fill_in "Book", with: @read_status.book_id
    fill_in "Finished date", with: @read_status.finished_date
    fill_in "Member", with: @read_status.member_id
    fill_in "Status", with: @read_status.status
    click_on "Create Read status"

    assert_text "Read status was successfully created"
    click_on "Back"
  end

  test "should update Read status" do
    visit read_status_url(@read_status)
    click_on "Edit this read status", match: :first

    fill_in "Book", with: @read_status.book_id
    fill_in "Finished date", with: @read_status.finished_date
    fill_in "Member", with: @read_status.member_id
    fill_in "Status", with: @read_status.status
    click_on "Update Read status"

    assert_text "Read status was successfully updated"
    click_on "Back"
  end

  test "should destroy Read status" do
    visit read_status_url(@read_status)
    click_on "Destroy this read status", match: :first

    assert_text "Read status was successfully destroyed"
  end
end
