require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
    

    test "save friendship" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"
    
        friendship = Friendship.new(user:user, friend:friend)
        assert friendship.save
    end

    test "not save friendship for duplicates" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"
    
        friendship = Friendship.new(user:user, friend:friend)
        assert friendship.save
    
        duplicate = Friendship.new(user:user, friend:friend)
        failed = !duplicate.save
        assert failed 
      end

    test "not save blocked friend" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"

        blacklist = Blacklist.new(by_user:user, blocked:friend)
        assert blacklist.save

        friendship = Friendship.new(user:user, friend:friend)
        failed = !friendship.save
        assert failed

        friendship = Friendship.new(user:friend, friend:user)
        failed = !friendship.save
        assert failed
    end

    test "not save invalid user email" do
        user = "#{SecureRandom.hex}"
        friend = "#{SecureRandom.hex}@test.com"
    
        friendship = Friendship.new(user:user, friend:friend)
        failed = !friendship.save
        assert failed
    end

    test "not save invalid friend email" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}"
    
        friendship = Friendship.new(user:user, friend:friend)
        failed = !friendship.save
        assert failed
    end

    test "not save empty user email" do
        user = nil
        friend = "#{SecureRandom.hex}@test.com"
    
        friendship = Friendship.new(user:user, friend:friend)
        failed = !friendship.save
        assert failed
    end

    test "not save empty friend email" do
        user = "#{SecureRandom.hex}@test.com"
        friend = nil

        friendship = Friendship.new(user:user, friend:friend)
        failed = !friendship.save
        assert failed
    end

    test "test parse_two_friends - two different value" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"
        r = Friendship.parse_two_friends([user, friend])
        assert r[:success] 
    end

    test "test parse_two_friends - two same value" do
        user = "#{SecureRandom.hex}@test.com"
        friend = user
        r = Friendship.parse_two_friends([user, friend])
        assert !r[:success] 
    end

    test "test parse_two_friends - three different value" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"
        another = "#{SecureRandom.hex}@test.com"
        r = Friendship.parse_two_friends([user, friend, another])
        assert !r[:success] 
    end

    test "test parse_two_friends - not array" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"
        r = Friendship.parse_two_friends([user, friend].to_s)
        assert !r[:success] 
    end


    test "test parse_two_friends - one value" do
        user = "#{SecureRandom.hex}@test.com"
        r = Friendship.parse_two_friends([user])
        assert !r[:success] 
    end

    test "test create - two different value" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"
        r = Friendship.create(user, friend)
        assert r[:success] 

        c1 = Friendship.where(user:user).where(friend:friend).size
        assert c1 == 1

        c2 = Friendship.where(user:friend).where(friend:user).size
        assert c2 == 1
    end

    test "test create - invalid emails" do
        user = "#{SecureRandom.hex}"
        friend = "#{SecureRandom.hex}"
        r = Friendship.create(user, friend)
        assert !r[:success] 
    end

    test "test create - blocked friend" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"

        blacklist = Blacklist.new(by_user:user, blocked:friend)
        assert blacklist.save

        r = Friendship.create(user, friend)
        assert !r[:success] 

        r = Friendship.create(friend, user)
        assert !r[:success] 
    end

    test "common friend - zeor common friend" do
        user = "#{SecureRandom.hex}@test.com"
        friend = "#{SecureRandom.hex}@test.com"
        r = Friendship.create(user, friend)
        assert r[:success] 

        user2 = "#{SecureRandom.hex}@test.com"
        friend2 = "#{SecureRandom.hex}@test.com"
        r = Friendship.create(user2, friend2)
        assert r[:success]

        common = Friendship.common_friends(user, user2)
        assert common == []

        common = Friendship.common_friends(user2, user)
        assert common == []
    end

    test "common friend - some common friend" do
        user = "#{SecureRandom.hex}@test.com"
        (0..5).each do
            f = "#{SecureRandom.hex}@test.com"
            r = Friendship.create(user, f)
            assert r[:success]
        end

        user2 = "#{SecureRandom.hex}@test.com"
        (0..5).each do
            f = "#{SecureRandom.hex}@test.com"
            r = Friendship.create(user2, f)
            assert r[:success]
        end

        commonlist = []
        (0..5).each do
            f = "#{SecureRandom.hex}@test.com"
            commonlist << f

            r = Friendship.create(user, f)
            assert r[:success]

            r = Friendship.create(user2, f)
            assert r[:success]
        end
        commonlist = commonlist.sort
        
        common = Friendship.common_friends(user, user2).sort
        assert common.size == 6

        common2 = Friendship.common_friends(user2, user).sort
        assert common2.size == 6

        assert common == common2
        assert common == commonlist
    end
    
end