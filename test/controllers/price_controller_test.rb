require 'test_helper'

class PriceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get price_index_url
    assert_response :success
  end

  test "should get new" do
    get price_new_url
    assert_response :success
  end

  test "should get create" do
    get price_create_url
    assert_response :success
  end

  test "should get update" do
    get price_update_url
    assert_response :success
  end

  test "should get show" do
    get price_show_url
    assert_response :success
  end

  test "should get delete" do
    get price_delete_url
    assert_response :success
  end

end
