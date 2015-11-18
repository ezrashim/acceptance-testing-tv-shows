require 'sinatra'
require 'csv'
require_relative "app/models/television_show"
require'pry'

set :views, File.join(File.dirname(__FILE__), "app/views")


get '/television_shows' do
  @television_shows = CSV.read('television-shows.csv', headers: true, header_converters: :symbol)
    title = params[:title]
    network = params[:network]
    starting_year= params[:starting_year]
    synopsis= params[:synopsis]
    genre= params[:genre]

  erb :index
end

get '/television_shows/new' do
  erb :new
end

post '/television_shows/new' do
  @television_shows = CSV.read('television-shows.csv', headers: true, header_converters: :symbol)
    title = params[:title]
    network = params[:network]
    starting_year= params[:starting_year]
    synopsis= params[:synopsis]
    genre= params[:genre]
    data = [title, network, starting_year, synopsis, genre]
    CSV.open('television-shows.csv', 'a') do |csv|
      csv << [title,network,starting_year,synopsis,genre]
    erb :new
  end

    redirect '/television_shows'
end
