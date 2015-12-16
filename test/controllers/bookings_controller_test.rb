require 'test_helper'

class BookingsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
