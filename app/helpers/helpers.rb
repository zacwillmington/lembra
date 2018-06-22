# class Helpers
#
#     def current_user
#         @current_user ||= User.find(session[:id]) if session[:id]
#     end
#
#     def is_logged_in?
#         !!current_user
#     end
#
#     # def self.is_params_empty?(params)
#     #     params['username'] == "" || params['email'] == "" || params['password'] == "" || params['content'] == ""
#     # end
#
#     def self.calculate_learnt_cards(deck)
#         learnt_cards = deck.cards.collect do |card|
#             card.learnt == true
#         end.size
#     end
#
#     def self.number_of_cards_in_deck(deck)
#         deck.cards.all.size
#     end
#
# end
