class DeckController < ApplicationController


    get '/users/:id/decks' do
        erb :'/decks/decks'
    end

    get '/users/:id/decks/new' do
        if is_logged_in? && current_user.id == params[:id].to_i
            erb :'/decks/create_deck'
        else
            @user = User.find(params[:id])
            flash[:message] = { :error => ["Only #{@user.username} is able to edit their account information."]}
            redirect to '/login'
        end
    end

    post '/users/:id/decks' do
        @deck = Deck.new(:title => params['title'], :category => params['category'])
         if @deck.valid?
             @deck.save
             current_user.decks << @deck
             current_user.save
            redirect to "/users/#{@deck.user.id}/decks/#{@deck.id}"
        else
            flash[:message] = @deck.errors.messages
            redirect to "/users/#{current_user.id}/decks/new"
        end
    end

    get '/users/:id/decks/:deck_id' do

        erb :'decks/show_deck'
    end

    get '/users/:id/decks/:deck_id/edit' do
        if is_logged_in? && current_user.decks.include?(current_deck)
            erb :'/decks/edit_deck'
        else
            @user = User.find(params[:id])
            flash[:message] = {:error => ["You are unable to edit this deck."]}
            redirect to "/users/#{current_user.id}/decks"
        end

    end

    patch  '/users/:id/decks/:deck_id' do

        if current_deck.user.id == current_user.id
            current_deck.update(:title => params['title'], :category => params['category'])
            if current_deck.valid?
                current_deck.save
            else
                flash[:message] = current_deck.errors.messages
                redirect to "/users/#{current_user.id}/decks/#{current_deck.id}/edit"
            end
        end
            redirect "/users/#{current_user.id}/decks"
    end

    delete '/users/:id/decks/:deck_id/delete' do

        if is_logged_in? && current_user.id == params[:id].to_i
            current_deck = Deck.find_by(:id => params[:deck_id])
            card_ids = current_deck.cards.ids
            Card.where(:id => card_ids).delete_all
            current_deck.delete
            redirect to "/users/#{current_user.id}/decks"
        else
            flash[:message] = {:error => "You are unable to delete this deck."}
            redirect to "/users/#{current_user.id}/decks"
       end
    end
    #delete deck

end
