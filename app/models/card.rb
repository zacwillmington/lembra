class Card < ActiveRecord::Base
    belongs_to :deck
    validates :front_side, :back_side, presence: true
    validates :front_side, length: { maximum: 10, too_long: "%{count} characters is the maximum allowed" }
    validates :back_side, length: { maximum: 10, too_long: "%{count} characters is the maximum allowed" }
end
