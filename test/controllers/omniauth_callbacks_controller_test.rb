require 'test_helper'

class OmniauthCallbacksControllerTest < ActionController::TestCase
  test "should get inkdrop" do
    get :inkdrop
    assert_response :success
  end

end
