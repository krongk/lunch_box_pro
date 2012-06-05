require 'test_helper'

class OrderDetailsControllerTest < ActionController::TestCase
  setup do
    @order_detail = order_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_detail" do
    assert_difference('OrderDetail.count') do
      post :create, order_detail: @order_detail.attributes
    end

    assert_redirected_to order_detail_path(assigns(:order_detail))
  end

  test "should show order_detail" do
    get :show, id: @order_detail.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_detail.to_param
    assert_response :success
  end

  test "should update order_detail" do
    put :update, id: @order_detail.to_param, order_detail: @order_detail.attributes
    assert_redirected_to order_detail_path(assigns(:order_detail))
  end

  test "should destroy order_detail" do
    assert_difference('OrderDetail.count', -1) do
      delete :destroy, id: @order_detail.to_param
    end

    assert_redirected_to order_details_path
  end
end
