class CardController < ApplicationController

    get '/users/:id/decks/:deck_id/cards' do
        @deck = Deck.find_by(:id => params[:deck_id])
        redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}"
    end

    get '/users/:id/decks/:deck_id/cards/new' do
        @deck = Deck.find_by(:id => params[:deck_id])
        if @deck.user.id == current_user.id
            erb :'/cards/create_card'
        else
            redirect to "/users/#{current_user.id}/decks"
        end
    end

    post '/users/:id/decks/:deck_id/cards' do
        @deck = Deck.find_by(:id => params[:deck_id])

        @card = Card.new(:front_side => params['front_side'], :back_side => params['back_side'], :learnt => "No")
        if @card.valid?
            @card.save
            @deck.cards << @card
            @deck.number_of_cards = @deck.cards.all.size
            @deck.save
            redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}/cards"
        else
            flash[:message] = @card.errors.messages
            redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}/cards/new"
        end
    end

    get '/users/:id/decks/:deck_id/cards/:card_id' do
        current_card
        @deck = Deck.find_by(:id => params[:deck_id])
        erb :'/cards/show_card'
    end

    post '/users/:id/decks/:deck_id/cards/:card_id/next' do
        current_card
        @deck = Deck.find_by(:id => params[:deck_id])
        next_card_id(current_card
            .deck)
        if @next_id == nil
            redirect to "/users/#{current_user.id}/decks/#{@deck.id}/cards/#{@deck.cards.first.id}"
        else
            redirect to "/users/#{current_user.id}/decks/#{@deck.id}/cards/#{@next_id}"
        end
    end

    post '/users/:id/decks/:deck_id/cards/:card_id/flip' do
        current_card
        @deck = Deck.find_by(:id => params[:deck_id])
        if params['Hide'] == 'Hide'
            current_card.update(:flip => nil)
            current_card.save
        end
        if params['Flip'] == 'Flip'
            current_card.update(:flip => true)
            current_card.save
        end
        redirect to "/users/#{current_user.id}/decks/#{@deck.id}/cards/#{current_card.id}"
    end

    get '/users/:id/decks/:deck_id/cards/:card_id/edit' do
        if is_logged_in? && current_user.id == params[:id].to_i
            @deck = Deck.find_by(:id => params[:deck_id])
            current_card
            erb :'/cards/edit_card'
        else
            redirect to "/users/#{current_user.id}/decks"
        end
    end

    patch '/users/:id/decks/:deck_id/cards/:card_id' do
        current_card
        @deck = Deck.find_by(:id => params[:deck_id])
        if @deck.user.id == current_user.id
            if params["Learnt?"] == "Learnt?"
                current_card.update(:learnt => "Yes")
                current_card.save
            else
                current_card.update(:front_side => params['front_side'], :back_side => params['back_side'])
                if current_card.valid?
                    current_card.save
                end
            end
            redirect to "/users/#{current_user.id}/decks/#{@deck.id}/cards/#{current_card.id}"
        else
            redirect to "/users/#{current_user.id}/decks"
        end
    end

    delete '/users/:id/decks/:deck_id/cards/:card_id/delete' do

        if is_logged_in? && current_user.id == params[:id].to_i
            @deck = Deck.find_by(:id => params[:deck_id])
            Card.find_by(:id => params['card_id']).delete
            redirect to "/users/#{current_user.id}/decks/#{@deck.id}/cards"
        else
            redirect to "/users/#{current_user.id}"
       end
    end

end
