require 'test_helper'

class FriendshipControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    user = "#{SecureRandom.hex}@test.com"
    friend = "#{SecureRandom.hex}@test.com"

    post friendship_url,  params:{ "friends": [user, friend]}
    assert_response :success
  end


  test "should get friend list" do
    email = "#{SecureRandom.hex}@test.com"

    get friendship_url, params:{ "email": email}
    assert_response :success
  end
  
end
  