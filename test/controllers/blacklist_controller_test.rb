require 'test_helper'

class BlacklistControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    by_user = "#{SecureRandom.hex}@test.com"
    blocked = "#{SecureRandom.hex}@test.com"

    post blacklist_url,  params:{ "requestor": by_user, "target":blocked}
    assert_response :success
  end

end
