require 'test_helper'

class RegionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get regions_index_url
    assert_response :success
  end

  test "should get new" do
    get regions_new_url
    assert_response :success
  end

  test "should get create" do
    get regions_create_url
    assert_response :success
  end

  test "should get show" do
    get regions_show_url
    assert_response :success
  end

  test "should get update" do
    get regions_update_url
    assert_response :success
  end

  test "should get delete" do
    get regions_delete_url
    assert_response :success
  end

end
