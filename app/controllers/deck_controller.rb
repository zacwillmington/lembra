class DeckController < ApplicationController


    get '/users/:id/decks' do
        @user = Helpers.current_user(session)
        erb :'/decks/decks'
    end

    get '/users/:id/decks/new' do
        @user = Helpers.current_user(session)
        erb :'/decks/create_deck'
    end

    post '/users/:id/decks' do
        binding.pry
         @deck = Deck.create(:title => params['title'], :category => params['category'])
         @user = Helpers.current_user(session)
         @user.decks << @deck
         @user.save
        redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}"
    end

    get '/users/:id/decks/:deck_id' do
        @deck = Deck.find_by(:id => params[:deck_id])
        erb :'decks/show_deck'
    end

    get '/users/:id/decks/:deck_id/edit' do
        @deck = Deck.find_by(:id => params[:id])
        erb :'/decks/edit_deck'
    end

    post 'users/:id/decks/:deck_id' do
        @deck = Deck.find_by(:id => params[:deck_id])
        if @deck.user.id == Helpers.current_user(session).id
            @deck.title = params['title']
            @deck.category = params['category']
            @deck.save
            redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}"
        else
            redirect "/users/#{@deck.user.id}/decks"
        end
    end


end
