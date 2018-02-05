class Blacklist < ApplicationRecord
    include EmailValidatable

    validates :by_user, email: true
    validates :blocked, email: true

    validates :by_user, presence: true
    validates :blocked, presence: true

    validates :blocked, uniqueness: { scope: :by_user }
end
