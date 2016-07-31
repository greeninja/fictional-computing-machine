require 'test_helper'

class RatTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rat_type = rat_types(:one)
  end

  test "should get index" do
    get rat_types_url
    assert_response :success
  end

  test "should get new" do
    get new_rat_type_url
    assert_response :success
  end

  test "should create rat_type" do
    assert_difference('RatType.count') do
      post rat_types_url, params: { rat_type: {  } }
    end

    assert_redirected_to rat_type_url(RatType.last)
  end

  test "should show rat_type" do
    get rat_type_url(@rat_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_rat_type_url(@rat_type)
    assert_response :success
  end

  test "should update rat_type" do
    patch rat_type_url(@rat_type), params: { rat_type: {  } }
    assert_redirected_to rat_type_url(@rat_type)
  end

  test "should destroy rat_type" do
    assert_difference('RatType.count', -1) do
      delete rat_type_url(@rat_type)
    end

    assert_redirected_to rat_types_url
  end
end
