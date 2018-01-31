require 'test_helper'

class CoinsUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get coins_users_index_url
    assert_response :success
  end

end
