require "application_system_test_case"

class AvailabilityCalendarsTest < ApplicationSystemTestCase
  setup do
    @availability_calendar = availability_calendars(:one)
  end

  test "visiting the index" do
    visit availability_calendars_url
    assert_selector "h1", text: "Availability calendars"
  end

  test "should create availability calendar" do
    visit availability_calendars_url
    click_on "New availability calendar"

    fill_in "Available date", with: @availability_calendar.available_date
    fill_in "Book", with: @availability_calendar.book_id
    fill_in "Reservation count", with: @availability_calendar.reservation_count
    click_on "Create Availability calendar"

    assert_text "Availability calendar was successfully created"
    click_on "Back"
  end

  test "should update Availability calendar" do
    visit availability_calendar_url(@availability_calendar)
    click_on "Edit this availability calendar", match: :first

    fill_in "Available date", with: @availability_calendar.available_date
    fill_in "Book", with: @availability_calendar.book_id
    fill_in "Reservation count", with: @availability_calendar.reservation_count
    click_on "Update Availability calendar"

    assert_text "Availability calendar was successfully updated"
    click_on "Back"
  end

  test "should destroy Availability calendar" do
    visit availability_calendar_url(@availability_calendar)
    click_on "Destroy this availability calendar", match: :first

    assert_text "Availability calendar was successfully destroyed"
  end
end
