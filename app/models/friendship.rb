require 'set'

class Friendship < ApplicationRecord
    include EmailValidatable
    
    validates :user, email: true
    validates :friend, email: true

    validates :user, presence: true
    validates :friend, presence: true

    validates :user, uniqueness: { scope: :friend }

    validate :not_blocked

    def not_blocked
        blocked  = Blacklist.where(by_user: self.user, blocked: self.friend).size
        other_blocked = Blacklist.where(by_user: self.friend, blocked: self.user).size
        if blocked != 0 or other_blocked != 0
            errors.add(:not_blocked, "is false")
        end 
    end

    def self.parse_two_friends(friends)
        payload = {success: false}

        if not friends.kind_of?(Array)
            payload[:error] = "Invalid data format. Cannot find friends field"
        else
            friends = friends.map{|f| f.downcase.strip}.to_set.to_a
            if friends.size < 2
                payload[:error] = "Invalid data format. Too few friends"
            elsif friends.size > 2
                payload[:error] = "Invalid data format. Too many friends"
            else
                payload[:success] = true
                payload[:friends] = friends
            end
        end

        return payload
    end

    def self.create(user, friend)
        ActiveRecord::Base.transaction do
            f1 = Friendship.new(user:user, friend:friend)
            f2 = Friendship.new(user:friend, friend:user)

            f1.save!
            f2.save!
        end

        return {success:true}
    rescue ActiveRecord::RecordInvalid => e
        return {success:false, error:e.message}
    end

    def self.common_friends(user, another_user)
        user_friends = Friendship.where(user: user).map{|f| f.friend}.to_set
        another_user_friends = Friendship.where(user: another_user).map{|f| f.friend}.to_set

        return user_friends.intersection(another_user_friends).to_a
    end
end
