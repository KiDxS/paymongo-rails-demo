require "test_helper"

class StaticpageControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should redirect to the purchase access page if user hasn't paid yet" do
    @user = users(:one)
    sign_in @user
    get root_path
    assert_redirected_to access_page_path
  end
  test 'should get index if user has paid' do
    @user = users(:two)
    sign_in @user
    get root_path
    assert_response :success
  end
end
