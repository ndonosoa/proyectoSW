require 'test_helper'

class ComunasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get comunas_index_url
    assert_response :success
  end

end
