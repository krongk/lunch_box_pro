require 'test_helper'

class ProductCatesControllerTest < ActionController::TestCase
  setup do
    @product_cate = product_cates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_cates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_cate" do
    assert_difference('ProductCate.count') do
      post :create, product_cate: @product_cate.attributes
    end

    assert_redirected_to product_cate_path(assigns(:product_cate))
  end

  test "should show product_cate" do
    get :show, id: @product_cate.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_cate.to_param
    assert_response :success
  end

  test "should update product_cate" do
    put :update, id: @product_cate.to_param, product_cate: @product_cate.attributes
    assert_redirected_to product_cate_path(assigns(:product_cate))
  end

  test "should destroy product_cate" do
    assert_difference('ProductCate.count', -1) do
      delete :destroy, id: @product_cate.to_param
    end

    assert_redirected_to product_cates_path
  end
end
