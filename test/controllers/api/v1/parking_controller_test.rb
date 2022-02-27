require 'test_helper'

class ParkingControllerTest < ActionDispatch::IntegrationTest
  test "should get park" do
    get parking_park_url
    assert_response :success
  end

  test "should get unpark" do
    get parking_unpark_url
    assert_response :success
  end

end
