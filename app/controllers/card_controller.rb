class CardController < ApplicationController

    get '/users/:id/decks/:deck_id/cards' do
        @user = Helpers.current_user(session)
        @deck = Deck.find_by(:id => params[:deck_id])
        redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}"
    end

    get '/users/:id/decks/:deck_id/cards/new' do
        binding.pry
        @user = Helpers.current_user(session)
        @deck = Deck.find_by(:id => params[:deck_id])
        if @deck.user.id == @user.id
            erb :'/cards/create_card'
        else
            redirect to "/users/#{@user.id}/decks"
        end
    end

    post '/users/:id/decks/:deck_id/cards' do
        @user = Helpers.current_user(session)
        @deck = Deck.find_by(:id => params[:deck_id])
        @card = Card.create(:front_side => params['front_side'], :back_side => params['back_side'])
        @deck.cards << @card
        # @deck.number_of_cards = @deck.cards.all.size
        @deck.save
        binding.pry
        redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}/cards"
    end

    get '/users/:id/decks/:deck_id/cards/:card_id' do
        binding.pry
        @card = Card.find_by(:id => params[:id])
        erb :'/cards/show_card'
    end

    get '/users/:id/decks/:deck_id/cards/:card_id/edit' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @deck = Deck.find_by(:id => params[:deck_id])
            @card = Card.find_by(:id => params[:card_id])
            erb :'/cards/edit_card'
        else
            redirect to "/users/#{@user.id}/decks"
        end
    end

    patch '/users/:id/decks/:deck_id/cards/:card_id' do
        binding.pry
        @card = Card.find_by(:id => params[:card_id])
        @deck = Deck.find_by(:id => params[:deck_id])
        @user = Helpers.current_user(session)
        if @deck.user.id == Helpers.current_user(session).id
            @card.front_side = params['front_side']
            @card.back_side = params['back_side']
            @card.save
            redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}/cards/#{@card.id}"
        else
            redirect to "/users/#{@user.id}/decks"
        end
    end
    #edit cards
     #delete card
end
