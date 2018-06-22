class CardController < ApplicationController

    get '/cards' do
        erb :'/cards/cards'
    end

    get '/cards/new' do
        binding.pry
        @user = Helpers.current_user(session)
        erb :'/cards/create_card'
    end

    get '/cards/:id' do
        binding.pry
        @card = Card.find_by(:id => params[:id])
        erb :'/cards/show_card'
    end

    get '/cards/:id/edit' do
        erb :'/cards/edit_card'
    end
end
