require 'test_helper'

class MessageTest < ActiveSupport::TestCase
    test "mention - some mentions" do
        text = "a@b.cc something in middle @a@b.bb and c@b.cc. Hahaha."
        expected = ['a@b.cc', 'a@b.bb', 'c@b.cc'].sort
    
        mentions = Message.mentions(text).sort
        assert mentions == expected
    end


    test "mention - no mentions" do
        text = "I don't want to menton anyone. "
        expected = []
    
        mentions = Message.mentions(text).sort
        assert mentions == expected
    end

    test "mention - mentions, but not email address." do
        text = "I don't want to menton anyone by emial. @whatdoyothin? @me, @who?"
        expected = []
    
        mentions = Message.mentions(text).sort
        assert mentions == expected
    end

    test "recipients - friends only" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"
        r = Friendship.create(user, friend)
        assert r[:success] 

        expected = [friend]
        recipients = Message.recipients(user, "")

        assert recipients == expected
    end


    test "recipients - subscription only" do
        by_user = "#{SecureRandom.hex}@test.com"
        to_user = "#{SecureRandom.hex}@test.com"
    
        subscription = Subscription.new(by_user:by_user, to_user:to_user)
        assert subscription.save

        expected = [by_user]
        recipients = Message.recipients(to_user, "")

        assert recipients == expected
    end

    test "recipients - metions only" do
        text = "a@b.cc something in middle @a@b.bb and c@b.cc. Hahaha."
        expected = ['a@b.cc', 'a@b.bb', 'c@b.cc'].sort

        user = "#{SecureRandom.hex}@test.com"
        recipients = Message.recipients(user, text).sort

        assert recipients == expected
    end

    test "recipients - blocked friends only" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"
        r = Friendship.create(user, friend)
        assert r[:success] 

        blacklist = Blacklist.new(blocked:user, by_user:friend)
        assert blacklist.save

        expected = []
        recipients = Message.recipients(user, "")

        assert recipients == expected
    end

    test "recipients - blocked subscription only" do
        by_user = "#{SecureRandom.hex}@test.com"
        to_user = "#{SecureRandom.hex}@test.com"
        subscription = Subscription.new(by_user:by_user, to_user:to_user)
        assert subscription.save

        blacklist = Blacklist.new(blocked:to_user, by_user:by_user)
        assert blacklist.save

        expected = []
        recipients = Message.recipients(to_user, "")

        assert recipients == expected
    end

    test "recipients - blokced metions only" do
        by_user = "#{SecureRandom.hex}@test.com"
        mentioned = "#{SecureRandom.hex}@test.com"
        text = "I need to tell #{mentioned} about this thing."
        expected = []

        blacklist = Blacklist.new(blocked:by_user, by_user:mentioned)
        assert blacklist.save
        recipients = Message.recipients(by_user, text)
        assert recipients == expected
    end

    test "recipients - friend, subscription, mention" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"
        r = Friendship.create(user, friend)
        assert r[:success] 

        by_user = "#{SecureRandom.hex}@test.com"
        subscription = Subscription.new(to_user:user, by_user:by_user)
        assert subscription.save

        mentioned = "#{SecureRandom.hex}@test.com"
        text = "I need to tell #{mentioned} about this thing."

        expected = [friend, by_user, mentioned].sort

        recipients = Message.recipients(user, text).sort
        assert recipients == expected
    end
end