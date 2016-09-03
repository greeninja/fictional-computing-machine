require 'test_helper'

class QaSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qa_setting = qa_settings(:one)
  end

  test "should get index" do
    get qa_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_qa_setting_url
    assert_response :success
  end

  test "should create qa_setting" do
    assert_difference('QaSetting.count') do
      post qa_settings_url, params: { qa_setting: {  } }
    end

    assert_redirected_to qa_setting_url(QaSetting.last)
  end

  test "should show qa_setting" do
    get qa_setting_url(@qa_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_qa_setting_url(@qa_setting)
    assert_response :success
  end

  test "should update qa_setting" do
    patch qa_setting_url(@qa_setting), params: { qa_setting: {  } }
    assert_redirected_to qa_setting_url(@qa_setting)
  end

  test "should destroy qa_setting" do
    assert_difference('QaSetting.count', -1) do
      delete qa_setting_url(@qa_setting)
    end

    assert_redirected_to qa_settings_url
  end
end
