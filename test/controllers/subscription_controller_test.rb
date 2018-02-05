require 'test_helper'

class SubscriptionControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    by_user = "#{SecureRandom.hex}@test.com"
    to_user = "#{SecureRandom.hex}@test.com"

    post subscription_url, params:{ "requestor": by_user, "target":to_user}
    assert_response :success
  end

end
