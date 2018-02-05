require 'test_helper'

class BlacklistTest < ActiveSupport::TestCase
  test "save blacklist" do
    by_user = "#{SecureRandom.hex}@test.com"
    blocked = "#{SecureRandom.hex}@test.com"

    blacklist = Blacklist.new(by_user:by_user, blocked:blocked)
    assert blacklist.save
  end


  test "not save blacklist for duplicates" do
    by_user = "#{SecureRandom.hex}@test.com"
    blocked = "#{SecureRandom.hex}@test.com"

    blacklist = Blacklist.new(by_user:by_user, blocked:blocked)
    assert blacklist.save

    duplicate = Blacklist.new(by_user:by_user, blocked:blocked)
    failed = !duplicate.save
    assert failed 
  end

  test "not save invalid by_user email address" do
    by_user = "#{SecureRandom.hex}@test"
    blocked = "#{SecureRandom.hex}@test.com"

    blacklist = Blacklist.new(by_user:by_user, blocked:blocked)
    failed = !blacklist.save
    assert failed 
  end

  test "not save invalid blocked email address" do
    by_user = "#{SecureRandom.hex}@test.com"
    blocked = "#{SecureRandom.hex}@test"

    blacklist = Blacklist.new(by_user:by_user, blocked:blocked)
    failed = !blacklist.save
    assert failed 
  end

  test "not save empty by_user email address" do
    by_user = nil
    blocked = "#{SecureRandom.hex}@test"

    blacklist = Blacklist.new(by_user:by_user, blocked:blocked)
    failed = !blacklist.save
    assert failed 
  end

  test "not save empty blocked email address" do
    by_user = "#{SecureRandom.hex}@test"
    blocked = nil

    blacklist = Blacklist.new(by_user:by_user, blocked:blocked)
    failed = !blacklist.save
    assert failed 
  end

end
