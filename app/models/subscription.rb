class Subscription < ApplicationRecord
    include EmailValidatable

    validates :by_user, email: true
    validates :to_user, email: true

    validates :by_user, presence: true
    validates :to_user, presence: true

    validates :to_user, uniqueness: { scope: :by_user }
end
