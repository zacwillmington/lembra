 class UserController < ApplicationController

     configure do
       enable :sessions
       set :session_secret, "secret"
     end

     get '/signup' do
         if is_logged_in?
             redirect to "/users/#{current_user.id}"
         else
             erb :'/users/signup'
         end
     end

     post '/signup' do
          if is_logged_in?
              redirect to "/users/#{current_user.id}"
          else
            @user = User.create(:username => params['username'], :email => params['email'], :password => params['password'])
            if @user.valid?
                session[:id] = @user.id
                redirect to "/users/#{current_user.id}"
            else
                @user.errors.messages
                redirect to '/signup'
            end
        end
     end

     get '/login' do
         if is_logged_in?
             redirect to "/users/#{current_user.id}"
         else
             erb :'/users/login'
         end
     end

     post '/login' do
         @user = User.find_by(:email => params['email'])
         if @user != nil && @user.authenticate( params['password'])
            session[:id] = @user.id
            redirect to "/users/#{current_user.id}"
        else
            redirect to '/login'
        end
     end

     get '/users/:id' do
         if is_logged_in?
             redirect to "/users/#{current_user.id}/decks"
         else
             redirect to '/login'
         end
     end


     get '/logout' do
         session.clear
         redirect to '/login'
     end

     get '/users/:id/edit' do
         if is_logged_in? && current_user.id == params[:id].to_i
             erb :'users/account_settings'
         else
             redirect to '/login'
         end
     end

     post '/users/:id' do
        if current_user.id == params[:id].to_i
             current_user.update(:password => params['password'])
             if current_user.valid?
                 current_user.save
             end
             redirect to "/users/#{current_user.id}"
        else
            redirect to "/users/#{current_user.id}/decks"
        end
     end

     delete '/users/:id/delete' do
         if is_logged_in? && current_user.id == params[:id].to_i

             deck_ids = current_user.decks.map{|deck| deck.id}
             cards = Card.where(:deck_id => deck_ids)
             Card.delete(cards.ids)
             Deck.delete(deck_ids)
             User.delete(current_user.id)
             session.clear
             redirect to '/signup'
         else
             redirect to "/users/#{current_user.id}"
        end

     end

 end
