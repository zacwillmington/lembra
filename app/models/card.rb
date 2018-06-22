class Card < ActiveRecord::Base
    belongs_to :deck
    validates :front_side, :back_side, presence: true
end
