require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get site_map" do
    get :site_map
    assert_response :success
  end

end
