require 'test_helper'

class ShopVersionsControllerTest < ActionController::TestCase
  setup do
    @shop_version = shop_versions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_versions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_version" do
    assert_difference('ShopVersion.count') do
      post :create, shop_version: @shop_version.attributes
    end

    assert_redirected_to shop_version_path(assigns(:shop_version))
  end

  test "should show shop_version" do
    get :show, id: @shop_version.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_version.to_param
    assert_response :success
  end

  test "should update shop_version" do
    put :update, id: @shop_version.to_param, shop_version: @shop_version.attributes
    assert_redirected_to shop_version_path(assigns(:shop_version))
  end

  test "should destroy shop_version" do
    assert_difference('ShopVersion.count', -1) do
      delete :destroy, id: @shop_version.to_param
    end

    assert_redirected_to shop_versions_path
  end
end
