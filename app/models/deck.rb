class Deck < ActiveRecord::Base
    belongs_to :user
    has_many :cards
    validates :title, :category, presence: true
    validates :title, length: { maximum: 20, too_long: "%{count} characters is the maximum allowed" }
    validates :category, length: { maximum: 20, too_long: "%{count} characters is the maximum allowed" }
end
