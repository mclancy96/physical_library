require "test_helper"

class AvailabilityCalendarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @availability_calendar = availability_calendars(:one)
  end

  test "should get index" do
    get availability_calendars_url
    assert_response :success
  end

  test "should get new" do
    get new_availability_calendar_url
    assert_response :success
  end

  test "should create availability_calendar" do
    assert_difference("AvailabilityCalendar.count") do
      post availability_calendars_url, params: { availability_calendar: { available_date: @availability_calendar.available_date, book_id: @availability_calendar.book_id, reservation_count: @availability_calendar.reservation_count } }
    end

    assert_redirected_to availability_calendar_url(AvailabilityCalendar.last)
  end

  test "should show availability_calendar" do
    get availability_calendar_url(@availability_calendar)
    assert_response :success
  end

  test "should get edit" do
    get edit_availability_calendar_url(@availability_calendar)
    assert_response :success
  end

  test "should update availability_calendar" do
    patch availability_calendar_url(@availability_calendar), params: { availability_calendar: { available_date: @availability_calendar.available_date, book_id: @availability_calendar.book_id, reservation_count: @availability_calendar.reservation_count } }
    assert_redirected_to availability_calendar_url(@availability_calendar)
  end

  test "should destroy availability_calendar" do
    assert_difference("AvailabilityCalendar.count", -1) do
      delete availability_calendar_url(@availability_calendar)
    end

    assert_redirected_to availability_calendars_url
  end
end
