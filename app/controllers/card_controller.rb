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
        @card = Card.create(:front_side => params['front_side'], :back_side => params['back_side'])
        @deck.cards << @card
        # @deck.number_of_cards = @deck.cards.all.size
        @deck.save
        redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}/cards"
    end

    get '/users/:id/decks/:deck_id/cards/:card_id' do
        binding.pry
        @card = Card.find_by(:id => params[:card_id])
        @deck = Deck.find_by(:id => params[:deck_id])
        binding.pry
        erb :'/cards/show_card'
    end

    get '/users/:id/decks/:deck_id/cards/:card_id/edit' do
        if is_logged_in? && current_user.id == params[:id].to_i
            @deck = Deck.find_by(:id => params[:deck_id])
            @card = Card.find_by(:id => params[:card_id])
            erb :'/cards/edit_card'
        else
            redirect to "/users/#{current_user.id}/decks"
        end
    end

    patch '/users/:id/decks/:deck_id/cards/:card_id' do
        @card = Card.find_by(:id => params[:card_id])
        @deck = Deck.find_by(:id => params[:deck_id])
        if @deck.user.id == current_user.id
            @card.update(:front_side => params['front_side'], :back_side => params['back_side'])
            if @card.valid?
                @card.save
            end
            redirect to "/users/#{current_user.id}/decks/#{@deck.id}/cards/#{@card.id}"
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
