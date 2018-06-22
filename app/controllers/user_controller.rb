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
          else
            @user = User.create(:username => params['username'], :email => params['email'], :password => params['password'])
            binding.pry
            if @user.valid?
                session[:id] = @user.id
                redirect to "/users/#{current_user.id}"
            else
                binding.pry
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
         if @user.authenticate( params['password'])
            session[:id] = @user.id
            redirect to "/users/#{current_user.id}"
        else
            redirect to '/login'
        end
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
