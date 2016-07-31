require 'test_helper'

class TickTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tick_type = tick_types(:one)
  end

  test "should get index" do
    get tick_types_url
    assert_response :success
  end

  test "should get new" do
    get new_tick_type_url
    assert_response :success
  end

  test "should create tick_type" do
    assert_difference('TickType.count') do
      post tick_types_url, params: { tick_type: {  } }
    end

    assert_redirected_to tick_type_url(TickType.last)
  end

  test "should show tick_type" do
    get tick_type_url(@tick_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_tick_type_url(@tick_type)
    assert_response :success
  end

  test "should update tick_type" do
    patch tick_type_url(@tick_type), params: { tick_type: {  } }
    assert_redirected_to tick_type_url(@tick_type)
  end

  test "should destroy tick_type" do
    assert_difference('TickType.count', -1) do
      delete tick_type_url(@tick_type)
    end

    assert_redirected_to tick_types_url
  end
end
