require 'test_helper'

class MessageControllerTest < ActionDispatch::IntegrationTest
  test "should get recipients" do
    sender = "#{SecureRandom.hex}@test.com"

    get message_recipients_url, params:{ "sender": sender, "text":""}
    assert_response :success
  end

end
