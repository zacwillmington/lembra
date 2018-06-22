class User < ActiveRecord::Base
    has_many :decks
    has_secure_password
    validates :username, :email, :password, presence: true
end
