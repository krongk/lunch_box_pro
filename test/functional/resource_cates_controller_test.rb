require 'test_helper'

class ResourceCatesControllerTest < ActionController::TestCase
  setup do
    @resource_cate = resource_cates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resource_cates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resource_cate" do
    assert_difference('ResourceCate.count') do
      post :create, resource_cate: @resource_cate.attributes
    end

    assert_redirected_to resource_cate_path(assigns(:resource_cate))
  end

  test "should show resource_cate" do
    get :show, id: @resource_cate.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resource_cate.to_param
    assert_response :success
  end

  test "should update resource_cate" do
    put :update, id: @resource_cate.to_param, resource_cate: @resource_cate.attributes
    assert_redirected_to resource_cate_path(assigns(:resource_cate))
  end

  test "should destroy resource_cate" do
    assert_difference('ResourceCate.count', -1) do
      delete :destroy, id: @resource_cate.to_param
    end

    assert_redirected_to resource_cates_path
  end
end
