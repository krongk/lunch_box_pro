require 'test_helper'

class ShopDishVersionsControllerTest < ActionController::TestCase
  setup do
    @shop_dish_version = shop_dish_versions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_dish_versions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_dish_version" do
    assert_difference('ShopDishVersion.count') do
      post :create, shop_dish_version: @shop_dish_version.attributes
    end

    assert_redirected_to shop_dish_version_path(assigns(:shop_dish_version))
  end

  test "should show shop_dish_version" do
    get :show, id: @shop_dish_version.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_dish_version.to_param
    assert_response :success
  end

  test "should update shop_dish_version" do
    put :update, id: @shop_dish_version.to_param, shop_dish_version: @shop_dish_version.attributes
    assert_redirected_to shop_dish_version_path(assigns(:shop_dish_version))
  end

  test "should destroy shop_dish_version" do
    assert_difference('ShopDishVersion.count', -1) do
      delete :destroy, id: @shop_dish_version.to_param
    end

    assert_redirected_to shop_dish_versions_path
  end
end
