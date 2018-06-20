 class UserController < ApplicationController

     get '/signup' do
         if Helpers.is_logged_in?(session)
             @user = Helpers.current_user(session)
             redirect to "/users/#{@user.id}/decks"
         else
             erb :'/user/signup'
         end
     end

     post '/signup' do
          binding.pry
          if Helpers.is_logged_in?(session)
              @user = Helpers.current_user(session)
              redirect to "/users/#{@user.id}/decks"
        elsif Helpers.is_params_empty?(params)
            redirect to '/signup'
        else

            @user = User.create(:username => params['username'], :email => params['email'], :password => params['password'])
            binding.pry
            session[:id] = @user.id
            redirect to "/users/#{@user.id}/decks"
        end
     end

     get '/login' do
         erb :'/user/login'
     end

     post '/login' do
         redirect to "/users/#{@user.id}/decks"
     end

     get '/users/:id/decks' do

         if Helpers.current_user(session).id == params[:id].to_i
             @user = Helpers.current_user(session)
             binding.pry
             erb :'/user/show'
         elsif Helpers.is_logged_in?(session)
             binding.pry
             @user = User.find_by(:id => params[:id])
             erb :'/user/show'
         else
             binding.pry
             redirect to '/login'
         end
     end
 end
