class DeckController < ApplicationController


    get '/decks' do
        @user = Helpers.current_user(session)
        erb :'/decks/decks'
    end

    get '/decks/new' do
        erb :'/decks/create_deck'
    end

    get '/decks/:id' do
        @deck = Deck.find_by(:id => params[:id])
        erb :'decks/show_deck'
    end

    get '/decks/:id/edit' do
        erb :'/decks/edit_deck'
    end


end
