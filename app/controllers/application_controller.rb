require './config/environment'
require 'bcrypt'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
      if is_logged_in?
          redirect to "/users/#{current_user.id}"
      else
          erb :index
      end
  end

  helpers do
      def current_user
          @current_user ||= User.find(session[:id]) if session[:id]
      end

      def current_deck
          @current_deck ||= Deck.find(params[:deck_id])
      end

      def current_card
          @current_card ||= Card.find(params[:card_id])
      end

      def is_logged_in?
          !!current_user
      end

      def calculate_learnt_cards(deck)
           learnt = deck.cards.find_all do |card|
              card.learnt == "Yes"
          end
          if learnt.empty?
              0
          else
              learnt.size
          end
      end

      def number_of_cards_in_deck(deck)
          deck.cards.all.size
      end

       def next_card_id(deck)
           @current_id = params[:card_id].to_i
           @card_ids = deck.cards.ids
           
           @card_ids.each_with_index do |id, index|
                if @current_id == id
                    @next_id = @card_ids[index + 1]
                end
                if @next_id == nil
                    @last_id = @current_id
                end
           end
       end


  end
end
