class Deck < ActiveRecord::Base
    belongs_to :user
    has_many :cards
    validates :title, :category, presence: true
end
