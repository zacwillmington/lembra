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
  end
end
