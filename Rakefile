 ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'
require 'sinatra/activerecord'


desc "Interactive console with Pry"
task :console do
    Pry.start
end
