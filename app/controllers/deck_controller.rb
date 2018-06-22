class DeckController < ApplicationController


    get '/users/:id/decks' do
        erb :'/decks/decks'
    end

    get '/users/:id/decks/new' do
        erb :'/decks/create_deck'
    end

    post '/users/:id/decks' do
         @deck = Deck.create(:title => params['title'], :category => params['category'])
         current_user.decks << @deck
         current_user.save
        redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}"
    end

    get '/users/:id/decks/:deck_id' do
        @deck = Deck.find_by(:id => params[:deck_id])
        erb :'decks/show_deck'
    end

    get '/users/:id/decks/:deck_id/edit' do
        if is_logged_in? && current_user.id == params['id']
            @deck = Deck.find_by(:id => params[:id])
            erb :'/decks/edit_deck'
        else
            redirect to "/users/#{@deck.user.id}/decks"
        end

    end

    patch  '/users/:id/decks/:deck_id' do
        binding.pry
        @deck = Deck.find_by(:id => params[:deck_id])
        if @deck.user.id == current_user.id
            @deck.title = params['title']
            @deck.category = params['category']
            @deck.save
            redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}"
        else
            redirect "/users/#{@deck.user.id}/decks"
        end
    end

    #delete deck

end
