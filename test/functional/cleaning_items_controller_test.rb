require 'test_helper'

class CleaningItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cleaning_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cleaning_item" do
    assert_difference('CleaningItem.count') do
      post :create, :cleaning_item => { }
    end

    assert_redirected_to cleaning_item_path(assigns(:cleaning_item))
  end

  test "should show cleaning_item" do
    get :show, :id => cleaning_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cleaning_items(:one).to_param
    assert_response :success
  end

  test "should update cleaning_item" do
    put :update, :id => cleaning_items(:one).to_param, :cleaning_item => { }
    assert_redirected_to cleaning_item_path(assigns(:cleaning_item))
  end

  test "should destroy cleaning_item" do
    assert_difference('CleaningItem.count', -1) do
      delete :destroy, :id => cleaning_items(:one).to_param
    end

    assert_redirected_to cleaning_items_path
  end
end
