require 'test_helper'

class DishCatesControllerTest < ActionController::TestCase
  setup do
    @dish_cate = dish_cates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dish_cates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dish_cate" do
    assert_difference('DishCate.count') do
      post :create, dish_cate: @dish_cate.attributes
    end

    assert_redirected_to dish_cate_path(assigns(:dish_cate))
  end

  test "should show dish_cate" do
    get :show, id: @dish_cate.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dish_cate.to_param
    assert_response :success
  end

  test "should update dish_cate" do
    put :update, id: @dish_cate.to_param, dish_cate: @dish_cate.attributes
    assert_redirected_to dish_cate_path(assigns(:dish_cate))
  end

  test "should destroy dish_cate" do
    assert_difference('DishCate.count', -1) do
      delete :destroy, id: @dish_cate.to_param
    end

    assert_redirected_to dish_cates_path
  end
end
