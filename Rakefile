ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "Interactive console with Pry"
task :console do
    Pry.start
end
