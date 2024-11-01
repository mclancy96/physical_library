require "test_helper"

class ReadStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @read_status = read_statuses(:one)
  end

  test "should get index" do
    get read_statuses_url
    assert_response :success
  end

  test "should get new" do
    get new_read_status_url
    assert_response :success
  end

  test "should create read_status" do
    assert_difference("ReadStatus.count") do
      post read_statuses_url, params: { read_status: { book_id: @read_status.book_id, finished_date: @read_status.finished_date, member_id: @read_status.member_id, status: @read_status.status } }
    end

    assert_redirected_to read_status_url(ReadStatus.last)
  end

  test "should show read_status" do
    get read_status_url(@read_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_read_status_url(@read_status)
    assert_response :success
  end

  test "should update read_status" do
    patch read_status_url(@read_status), params: { read_status: { book_id: @read_status.book_id, finished_date: @read_status.finished_date, member_id: @read_status.member_id, status: @read_status.status } }
    assert_redirected_to read_status_url(@read_status)
  end

  test "should destroy read_status" do
    assert_difference("ReadStatus.count", -1) do
      delete read_status_url(@read_status)
    end

    assert_redirected_to read_statuses_url
  end
end
