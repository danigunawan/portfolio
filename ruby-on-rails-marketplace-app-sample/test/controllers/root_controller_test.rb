require 'test_helper'

class RootControllerTest < ActionController::TestCase
  test "should get dispatcher" do
    get :dispatcher
    assert_response :success
  end
end
