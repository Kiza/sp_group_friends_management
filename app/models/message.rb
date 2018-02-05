require 'set'

class Message

    def self.recipients(sender, text)
        send_to = Set.new

        friends = Friendship.where(user: sender).map{|f| f.friend}.to_set
        send_to = send_to.union(friends)

        fans = Subscription.where(to_user: sender).map{|s| s.by_user}.to_set
        send_to = send_to.union(fans)

        mentions = Message.mentions(text).to_set
        send_to = send_to.union(mentions)

        blocked = Blacklist.where(blocked: sender).map{|b| b.by_user}.to_set
        send_to = send_to.subtract(blocked)
        

        return send_to.to_a
    end

    def self.mentions(text)
        matches = text.scan(/(?:[^@\s]+)@(?:(?:[-a-z0-9]+\.)+[a-z]{2,})/i)
        return matches
    end
end