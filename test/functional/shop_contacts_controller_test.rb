require 'test_helper'

class ShopContactsControllerTest < ActionController::TestCase
  setup do
    @shop_contact = shop_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_contact" do
    assert_difference('ShopContact.count') do
      post :create, shop_contact: @shop_contact.attributes
    end

    assert_redirected_to shop_contact_path(assigns(:shop_contact))
  end

  test "should show shop_contact" do
    get :show, id: @shop_contact.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_contact.to_param
    assert_response :success
  end

  test "should update shop_contact" do
    put :update, id: @shop_contact.to_param, shop_contact: @shop_contact.attributes
    assert_redirected_to shop_contact_path(assigns(:shop_contact))
  end

  test "should destroy shop_contact" do
    assert_difference('ShopContact.count', -1) do
      delete :destroy, id: @shop_contact.to_param
    end

    assert_redirected_to shop_contacts_path
  end
end
