class DeckController < ApplicationController


    get '/decks' do
        @user = Helpers.current_user(session)
        erb :'/decks/decks'
    end

    get '/decks/new' do
        erb :'/decks/create_deck'
    end

    post '/decks' do
         binding.pry
         @deck = Deck.create(:title => params['title'], :category => params['category'])
         @user = Helpers.current_user(session)
         @user.decks << @deck
         @user.save
         binding.pry
        redirect to "/decks/#{@deck.id}"
    end

    get '/decks/:id' do
        @deck = Deck.find_by(:id => params[:id])
        erb :'decks/show_deck'
    end

    get '/decks/:id/edit' do
        @deck = Deck.find_by(:id => params[:id])
        erb :'/decks/edit_deck'
    end

    post '/decks/:id' do
        @deck = Deck.find_by(:id => params[:id])
        if @deck.user.id == Helpers.current_user(session).id
            @deck.title = params['title']
            @deck.category = params['category']
            @deck.save
            redirect to "/decks/#{@deck.id}"
        else
            redirect '/decks'
        end
    end


end
