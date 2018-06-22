 class UserController < ApplicationController

     get '/signup' do
         if Helpers.is_logged_in?(session)
             @user = Helpers.current_user(session)
             redirect to "/users/#{@user.id}"
         else
             erb :'/users/signup'
         end
     end

     post '/signup' do
          if Helpers.is_logged_in?(session)
              @user = Helpers.current_user(session)
              redirect to "/users/#{@user.id}"
        elsif !Helpers.is_params_empty?(params)
            @user = User.create(:username => params['username'], :email => params['email'], :password => params['password'])
            session[:id] = @user.id
            redirect to "/users/#{@user.id}"
        else
            redirect to '/signup'

        end
     end

     get '/login' do
         erb :'/users/login'
     end

     post '/login' do
         @user = User.find_by(:username => params['username'])
        if @user == nil
            redirect to '/signup'
        elsif @user.authenticate(params['password'])
            session[:id] = @user.id
            redirect to "/users/#{@user.id}"
        end
     end

     get '/users/:id' do
         #Allows only owner to view their decks via a redirect
         @user = Helpers.current_user(session)
         if Helpers.is_logged_in?(session)
             redirect to "/users/#{@user.id}/decks"
         else
             redirect to '/login'
         end
     end


     get '/logout' do
         session.clear
         redirect to '/login'
     end
 end
