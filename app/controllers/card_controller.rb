class CardController < ApplicationController

    get '/users/:id/decks/:deck_id/cards' do
        redirect to "/users/#{current_deck.user.id}/decks/#{current_deck.id}"
    end

    get '/users/:id/decks/:deck_id/cards/new' do
        if current_deck.user.id == current_user.id
            erb :'/cards/create_card'
        else
            redirect to "/users/#{current_user.id}/decks"
        end
    end

    post '/users/:id/decks/:deck_id/cards' do
        @card = Card.new(:front_side => params['front_side'], :back_side => params['back_side'], :learnt => "No")
        if @card.valid?
            @card.save
            current_deck.cards << @card
            current_deck.number_of_cards = current_deck.cards.all.size
            current_deck.save
            redirect to "/users/#{current_deck.user.id}/decks/#{current_deck.id}/cards"
        else
            flash[:message] = @card.errors.messages
            redirect to "/users/#{current_deck.user.id}/decks/#{current_deck.id}/cards/new"
        end
    end

    get '/users/:id/decks/:deck_id/cards/:card_id' do
        current_card
        erb :'/cards/show_card'
    end

    post '/users/:id/decks/:deck_id/cards/:card_id/next' do
        next_card_id(current_card
            .deck)
        if @next_id == nil
            redirect to "/users/#{current_user.id}/decks/#{current_deck.id}/cards/#{current_deck.cards.first.id}"
        else
            redirect to "/users/#{current_user.id}/decks/#{current_deck.id}/cards/#{@next_id}"
        end
    end

    post '/users/:id/decks/:deck_id/cards/:card_id/flip' do
        if params['Hide'] == 'Hide'
            current_card.update(:flip => nil)
            current_card.save
        end
        if params['Flip'] == 'Flip'
            current_card.update(:flip => true)
            current_card.save
        end
        redirect to "/users/#{current_user.id}/decks/#{current_deck.id}/cards/#{current_card.id}"
    end

    get '/users/:id/decks/:deck_id/cards/:card_id/edit' do
        if is_logged_in? && current_user.id == params[:id].to_i
            erb :'/cards/edit_card'
        else
            redirect to "/users/#{current_user.id}/decks"
        end
    end

    patch '/users/:id/decks/:deck_id/cards/:card_id' do
        if current_deck.user.id == current_user.id
            if params["Learnt?"] == "Learnt?"
                current_card.update(:learnt => "Yes")
                current_card.save
            else
                current_card.update(:front_side => params['front_side'], :back_side => params['back_side'])
                if current_card.valid?
                    current_card.save
                end
            end
            redirect to "/users/#{current_user.id}/decks/#{current_deck.id}/cards/#{current_card.id}"
        else
            redirect to "/users/#{current_user.id}/decks"
        end
    end

    delete '/users/:id/decks/:deck_id/cards/:card_id/delete' do
        if is_logged_in? && current_user.id == params[:id].to_i
            current_card.delete
            current_deck.number_of_cards = current_deck.cards.all.size
            redirect to "/users/#{current_user.id}/decks/#{current_deck.id}/cards"
        else
            redirect to "/users/#{current_user.id}"
       end
    end

end
