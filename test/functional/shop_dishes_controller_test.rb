require 'test_helper'

class ShopDishesControllerTest < ActionController::TestCase
  setup do
    @shop_dish = shop_dishes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_dishes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_dish" do
    assert_difference('ShopDish.count') do
      post :create, shop_dish: @shop_dish.attributes
    end

    assert_redirected_to shop_dish_path(assigns(:shop_dish))
  end

  test "should show shop_dish" do
    get :show, id: @shop_dish.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_dish.to_param
    assert_response :success
  end

  test "should update shop_dish" do
    put :update, id: @shop_dish.to_param, shop_dish: @shop_dish.attributes
    assert_redirected_to shop_dish_path(assigns(:shop_dish))
  end

  test "should destroy shop_dish" do
    assert_difference('ShopDish.count', -1) do
      delete :destroy, id: @shop_dish.to_param
    end

    assert_redirected_to shop_dishes_path
  end
end
