require 'test_helper'

class RatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rat = rats(:one)
  end

  test "should get index" do
    get rats_url
    assert_response :success
  end

  test "should get new" do
    get new_rat_url
    assert_response :success
  end

  test "should create rat" do
    assert_difference('Rat.count') do
      post rats_url, params: { rat: { latebreak: @rat.latebreak, longbreak: @rat.longbreak, offtask: @rat.offtask, other: @rat.other, users_id: @rat.users_id } }
    end

    assert_redirected_to rat_url(Rat.last)
  end

  test "should show rat" do
    get rat_url(@rat)
    assert_response :success
  end

  test "should get edit" do
    get edit_rat_url(@rat)
    assert_response :success
  end

  test "should update rat" do
    patch rat_url(@rat), params: { rat: { latebreak: @rat.latebreak, longbreak: @rat.longbreak, offtask: @rat.offtask, other: @rat.other, users_id: @rat.users_id } }
    assert_redirected_to rat_url(@rat)
  end

  test "should destroy rat" do
    assert_difference('Rat.count', -1) do
      delete rat_url(@rat)
    end

    assert_redirected_to rats_url
  end
end
