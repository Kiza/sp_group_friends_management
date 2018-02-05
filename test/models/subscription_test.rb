require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  test "save subscription" do
    by_user = "#{SecureRandom.hex}@test.com"
    to_user = "#{SecureRandom.hex}@test.com"

    subscription = Subscription.new(by_user:by_user, to_user:to_user)
    assert subscription.save
  end

  test "not save subscription for duplicates" do
    by_user = "#{SecureRandom.hex}@test.com"
    to_user = "#{SecureRandom.hex}@test.com"

    subscription = Subscription.new(by_user:by_user, to_user:to_user)
    assert subscription.save

    duplicate = Subscription.new(by_user:by_user, to_user:to_user)
    failed = !duplicate.save
    assert failed 
  end

  test "not save invalid by_user email address" do
    by_user = "#{SecureRandom.hex}@test"
    to_user = "#{SecureRandom.hex}@test.com"

    subscription = Subscription.new(by_user:by_user, to_user:to_user)
    failed = !subscription.save
    assert failed 
  end

  test "not save invalid blocked email address" do
    by_user = "#{SecureRandom.hex}@test.com"
    to_user = "#{SecureRandom.hex}@test"

    subscription = Subscription.new(by_user:by_user, to_user:to_user)
    failed = !subscription.save
    assert failed 
  end

  test "not save empty by_user email address" do
    by_user = nil
    to_user = "#{SecureRandom.hex}@test"

    subscription = Subscription.new(by_user:by_user, to_user:to_user)
    failed = !subscription.save
    assert failed 
  end

  test "not save empty blocked email address" do
    by_user = "#{SecureRandom.hex}@test"
    to_user = nil

    subscription = Subscription.new(by_user:by_user, to_user:to_user)
    failed = !subscription.save
    assert failed 
  end
end
