require 'test_helper'

class DropPointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drop_point = drop_points(:one)
  end

  test "should get index" do
    get drop_points_url, as: :json
    assert_response :success
  end

  test "should create drop_point" do
    assert_difference('DropPoint.count') do
      post drop_points_url, params: { drop_point: { location_id: @drop_point.location_id, route_id: @drop_point.route_id } }, as: :json
    end

    assert_response 201
  end

  test "should show drop_point" do
    get drop_point_url(@drop_point), as: :json
    assert_response :success
  end

  test "should update drop_point" do
    patch drop_point_url(@drop_point), params: { drop_point: { location_id: @drop_point.location_id, route_id: @drop_point.route_id } }, as: :json
    assert_response 200
  end

  test "should destroy drop_point" do
    assert_difference('DropPoint.count', -1) do
      delete drop_point_url(@drop_point), as: :json
    end

    assert_response 204
  end
end
