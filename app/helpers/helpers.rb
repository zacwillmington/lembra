class Helpers

    def self.current_user(session)
        if session[:id]
            @user = User.find(session[:id])
        else
            nil
        end
    end

    def self.is_logged_in?(session)
        if session[:id] &&  self.current_user(session).id == session[:id]
            true
        else
            false
        end
    end

    def self.is_params_empty?(params)
        params['username'] == "" || params['email'] == "" || params['password'] == "" || params['content'] == ""
    end

    def self.calculate_learnt_cards(deck)
        learnt_cards = deck.cards.collect do |card|
            card.learnt == true
        end.size
    end

end
