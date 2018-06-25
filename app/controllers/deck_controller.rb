class DeckController < ApplicationController


    get '/users/:id/decks' do
        erb :'/decks/decks'
    end

    get '/users/:id/decks/new' do
        erb :'/decks/create_deck'
    end

    post '/users/:id/decks' do
         @deck = Deck.new(:title => params['title'], :category => params['category'])
         if @deck.valid?
             current_user.decks << @deck
             current_user.save
            redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}"
        else
            redirect to "/users/#{current_user.id}/decks"
        end
    end

    get '/users/:id/decks/:deck_id' do
        @deck = Deck.find_by(:id => params[:deck_id])
        erb :'decks/show_deck'
    end

    get '/users/:id/decks/:deck_id/edit' do
        if is_logged_in? && current_user.id == params['id'].to_i
            @deck = Deck.find_by(:id => params[:id])
            erb :'/decks/edit_deck'
        else
            redirect to "/users/#{current_user.id}/decks"
        end

    end

    patch  '/users/:id/decks/:deck_id' do
        binding.pry
        @deck = Deck.find_by(:id => params[:deck_id])
        if @deck.user.id == current_user.id
            @deck.update(:title => params['title'], :category => params['category'])
            if @deck.valid?
                @deck.save
            end
        end
            redirect "/users/#{current_user.id}/decks"
    end

    delete '/users/:id/decks/:deck_id/delete' do
        binding.pry
        if is_logged_in? && current_user.id == params[:id].to_i
            @deck = Deck.find_by(:id => params[:deck_id])
            binding.pry
            @deck.cards.delete_all()
            @deck.delete
            redirect to "/users/#{current_user.id}/decks/#{@deck.id}/cards"
        else
            redirect to "/users/#{current_user.id}"
       end
    end
    #delete deck

end
