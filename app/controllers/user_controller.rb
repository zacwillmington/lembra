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
         if @user.authenticate( params['password'])
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

     get '/users/:id/account/edit' do
         if is_logged_in && current_user.id == params[:id]
             erb :'user/account_settings'
         else
             redirect to '/login'
         end
     end

     post '/user/:id/account/edit' do
         binding.pry
         redirect to "/users/#{current_user.id}/account"
     end

     get '/users/:id/delete' do
         binding.pry
         if is_logged_in && current_user.id == params[:id]
             current_user.delete
        end
             redirect to '/signup'
     end

 end
