require "test_helper"

class ResetPasswordControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get reset_password_edit_url
    assert_response :success
  end
end
