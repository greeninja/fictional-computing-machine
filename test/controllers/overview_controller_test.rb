require 'test_helper'

class OverviewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get overview_index_url
    assert_response :success
  end

end
