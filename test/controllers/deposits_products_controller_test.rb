require 'test_helper'

class DepositsProductsControllerTest < ActionController::TestCase
  setup do
    @deposits_product = deposits_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deposits_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deposits_product" do
    assert_difference('DepositsProduct.count') do
      post :create, deposits_product: { cantidad: @deposits_product.cantidad, precio: @deposits_product.precio }
    end

    assert_redirected_to deposits_product_path(assigns(:deposits_product))
  end

  test "should show deposits_product" do
    get :show, id: @deposits_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deposits_product
    assert_response :success
  end

  test "should update deposits_product" do
    patch :update, id: @deposits_product, deposits_product: { cantidad: @deposits_product.cantidad, precio: @deposits_product.precio }
    assert_redirected_to deposits_product_path(assigns(:deposits_product))
  end

  test "should destroy deposits_product" do
    assert_difference('DepositsProduct.count', -1) do
      delete :destroy, id: @deposits_product
    end

    assert_redirected_to deposits_products_path
  end
end
