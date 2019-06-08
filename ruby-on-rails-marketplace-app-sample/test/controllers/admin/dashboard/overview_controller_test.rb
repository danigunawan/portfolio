require 'test_helper'

class Admin::Dashboard::OverviewControllerTest < ActionController::TestCase
  test "should get overview" do
    get :overview
    assert_response :success
  end

end
