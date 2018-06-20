 class UserController < ApplicationController

     get '/signup' do
         erb :'/user/signup'
     end

     post '/signup' do
          binding.pry
          redirect to :'/users/<%=@user.id%>/decks'
     end

     get '/login' do
         erb :'/user/login'
     end

     post '/login' do
         redirect to :'/users/<%=@user.id%>/decks'
     end

     get '/users/:id/decks' do
         binding.pry
         erb :'/users/show'
     end
 end
