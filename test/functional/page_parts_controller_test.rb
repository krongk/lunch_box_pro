require 'test_helper'

class PagePartsControllerTest < ActionController::TestCase
  setup do
    @page_part = page_parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_part" do
    assert_difference('PagePart.count') do
      post :create, page_part: @page_part.attributes
    end

    assert_redirected_to page_part_path(assigns(:page_part))
  end

  test "should show page_part" do
    get :show, id: @page_part.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page_part.to_param
    assert_response :success
  end

  test "should update page_part" do
    put :update, id: @page_part.to_param, page_part: @page_part.attributes
    assert_redirected_to page_part_path(assigns(:page_part))
  end

  test "should destroy page_part" do
    assert_difference('PagePart.count', -1) do
      delete :destroy, id: @page_part.to_param
    end

    assert_redirected_to page_parts_path
  end
end
