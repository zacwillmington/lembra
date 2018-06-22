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
         binding.pry
          if is_logged_in?
              redirect to "/users/#{current_user.id}"
          elsif !Helpers.is_params_empty?(params)
            @user = User.create(:username => params['username'], :email => params['email'], :password => params['password'])
            session[:id] = @user.id
            redirect to "/users/#{current_user.id}"
         else
            redirect to '/signup'
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
         binding.pry
         if current_user.authenticate(params)
            session[:id] = current_user.id
            redirect to "/users/#{current_user.id}"
     end

     get '/users/:id' do
         #Allows only owner to view their decks via a redirect
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


     #edit account_info in account_settings.erb
     #delete user in account_settings.erb


 end
