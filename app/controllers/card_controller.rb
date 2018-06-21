class CardController < ApplicationController

    get '/cards' do
        erb :'/cards/cards'
    end

    get '/cards/:id' do
        erb :'/cards/show_card'
    end

    get '/cards/new' do
        erb :'/cards/create_card'
    end

    get '/cards/:id/edit' do
        erb :'/cards/edit_card'
    end
end
