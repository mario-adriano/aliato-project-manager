require "test_helper"

class OperatorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get operators_index_url
    assert_response :success
  end

  test "should get edit" do
    get operators_edit_url
    assert_response :success
  end

  test "should get new" do
    get operators_new_url
    assert_response :success
  end
end
