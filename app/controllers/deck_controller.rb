class DeckController < ApplicationController


    get '/users/:id/decks' do
        erb :'/decks/decks'
    end

    get '/users/:id/decks/new' do
        @deck = Deck.find(:deck_id)
        if is_logged_in? && current_user.decks.include?(@deck)
            erb :'/decks/create_deck'
        else
            @user = User.find(params[:id])
            flash[:message] = "Only #{@user.username} is able to edit their account information."
            redirect to '/login'
        end
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
        binding.pry
        @deck = Deck.find(params[:deck_id])
        if is_logged_in? && current_user.decks.include?(@deck)
            erb :'/decks/edit_deck'
        else
            @user = User.find(params[:id])
            flash[:message] = {:error => ["You are unable to edit this deck."]}
            redirect to "/users/#{current_user.id}/decks"
        end

    end

    patch  '/users/:id/decks/:deck_id' do
        @deck = Deck.find_by(:id => params[:deck_id])
        if @deck.user.id == current_user.id
            @deck.update(:title => params['title'], :category => params['category'])
            if @deck.valid?
                @deck.save
            else
                binding.pry
                flash[:message] = @deck.errors.messages
                redirect to "/users/#{current_user.id}/decks/#{@deck.id}/edit"
            end
        end
            redirect "/users/#{current_user.id}/decks"
    end

    delete '/users/:id/decks/:deck_id/delete' do

        if is_logged_in? && current_user.id == params[:id].to_i
            @deck = Deck.find_by(:id => params[:deck_id])
            binding.pry
            @deck.cards.delete_all()
            @deck.delete
            redirect to "/users/#{current_user.id}/decks/#{@deck.id}/cards"
        else
            binding.pry
            flash[:message] = {:error => "You are unable to delete this deck."}
            redirect to "/users/#{current_user.id}/decks"
       end
    end
    #delete deck

end
