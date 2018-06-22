class CardController < ApplicationController

    get '/users/:id/decks/:deck_id/cards' do
        erb :'/cards/cards'
    end

    get '/users/:id/decks/:deck_id/cards/new' do
        binding.pry
        @user = Helpers.current_user(session)
        @deck = Deck.find_by(:id => params[:deck_id])
        erb :'/cards/create_card'
    end

    get '/users/:id/decks/:deck_id/cards/:card_id' do
        binding.pry
        @card = Card.find_by(:id => params[:id])
        erb :'/cards/show_card'
    end

    get '/users/:id/decks/:deck_id/cards/:card_id/edit' do
        erb :'/cards/edit_card'
    end
end
