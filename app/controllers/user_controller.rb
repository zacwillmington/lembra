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
         binding.pry
         @user = Helpers.current_user(session)
         if @user.id == params[:id].to_i
             erb :'/user/show'
         elsif !Helpers.is_logged_in?(session)
             redirect to '/login'
         else
             binding.pry
             @user = User.Find_by(:id => params[:id])
             erb :'/user/show'
         end
     end
 end
