class DeckController < ApplicationController

    get '/decks' do
    
    end

    get '/decks/:id' do
        @deck = Deck.find_by(:id => params[:id])
        erb :'decks/show'
    end

    get '/decks/:id/edit' do

    end


end
