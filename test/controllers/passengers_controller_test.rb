require 'test_helper'

class PassengersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @passenger = passengers(:one)
  end

  test "should get index" do
    get passengers_url, as: :json
    assert_response :success
  end

  test "should create passenger" do
    assert_difference('Passenger.count') do
      post passengers_url, params: { passenger: { drop_point_id: @passenger.drop_point_id, reserved_seats: @passenger.reserved_seats, ride_id: @passenger.ride_id, user_id: @passenger.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show passenger" do
    get passenger_url(@passenger), as: :json
    assert_response :success
  end

  test "should update passenger" do
    patch passenger_url(@passenger), params: { passenger: { drop_point_id: @passenger.drop_point_id, reserved_seats: @passenger.reserved_seats, ride_id: @passenger.ride_id, user_id: @passenger.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy passenger" do
    assert_difference('Passenger.count', -1) do
      delete passenger_url(@passenger), as: :json
    end

    assert_response 204
  end
end
