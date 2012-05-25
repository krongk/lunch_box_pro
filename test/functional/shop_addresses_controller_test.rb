require 'test_helper'

class ShopAddressesControllerTest < ActionController::TestCase
  setup do
    @shop_address = shop_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_address" do
    assert_difference('ShopAddress.count') do
      post :create, shop_address: @shop_address.attributes
    end

    assert_redirected_to shop_address_path(assigns(:shop_address))
  end

  test "should show shop_address" do
    get :show, id: @shop_address.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_address.to_param
    assert_response :success
  end

  test "should update shop_address" do
    put :update, id: @shop_address.to_param, shop_address: @shop_address.attributes
    assert_redirected_to shop_address_path(assigns(:shop_address))
  end

  test "should destroy shop_address" do
    assert_difference('ShopAddress.count', -1) do
      delete :destroy, id: @shop_address.to_param
    end

    assert_redirected_to shop_addresses_path
  end
end
