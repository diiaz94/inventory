require 'test_helper'

class ClosuresControllerTest < ActionController::TestCase
  setup do
    @closure = closures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:closures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create closure" do
    assert_difference('Closure.count') do
      post :create, closure: { seller_id: @closure.seller_id }
    end

    assert_redirected_to closure_path(assigns(:closure))
  end

  test "should show closure" do
    get :show, id: @closure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @closure
    assert_response :success
  end

  test "should update closure" do
    patch :update, id: @closure, closure: { seller_id: @closure.seller_id }
    assert_redirected_to closure_path(assigns(:closure))
  end

  test "should destroy closure" do
    assert_difference('Closure.count', -1) do
      delete :destroy, id: @closure
    end

    assert_redirected_to closures_path
  end
end
