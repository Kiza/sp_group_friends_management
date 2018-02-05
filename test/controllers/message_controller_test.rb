require 'test_helper'

class MessageControllerTest < ActionDispatch::IntegrationTest
  test "should get recipients" do
    sender = "#{SecureRandom.hex}@test.com"

    get message_recipients_url, params:{ "sender": sender, "text":""}
    assert_response :success
  end

  test "should get recipients - no text" do
    sender = "#{SecureRandom.hex}@test.com"

    get message_recipients_url, params:{ "sender": sender, "wrong-input":""}
    assert_response :success
  end

  test "should get recipients - no sender" do
    sender = "#{SecureRandom.hex}@test.com"

    get message_recipients_url, params:{ "wrong-input": sender, "text":""}
    assert_response :success
  end

end
