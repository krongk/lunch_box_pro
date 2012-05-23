require 'test_helper'

class ProjectCatesControllerTest < ActionController::TestCase
  setup do
    @project_cate = project_cates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_cates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_cate" do
    assert_difference('ProjectCate.count') do
      post :create, project_cate: @project_cate.attributes
    end

    assert_redirected_to project_cate_path(assigns(:project_cate))
  end

  test "should show project_cate" do
    get :show, id: @project_cate.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_cate.to_param
    assert_response :success
  end

  test "should update project_cate" do
    put :update, id: @project_cate.to_param, project_cate: @project_cate.attributes
    assert_redirected_to project_cate_path(assigns(:project_cate))
  end

  test "should destroy project_cate" do
    assert_difference('ProjectCate.count', -1) do
      delete :destroy, id: @project_cate.to_param
    end

    assert_redirected_to project_cates_path
  end
end
