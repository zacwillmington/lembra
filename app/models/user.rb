class User < ActiveRecord::Base
    has_many :decks
    has_secure_password
    validates :username, presence: true, length: { minimum: 6 }, uniqueness: true
    validates :email, presence: true
    validates :password, presence: true, length: { in: 6..15, too_short: "%{count} characters is the minimum allowed" }
end
