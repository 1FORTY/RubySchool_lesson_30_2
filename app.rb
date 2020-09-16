#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3 }
  validates :phone, presence: true, length: { minimum: 11 }
  validates :datestamp, presence: true, length: { minimum: 10 }
  validates :color, presence: true
end

class Barber < ActiveRecord::Base

end

before do
  @barbers = Barber.all
end

get '/' do
  erb :index
end

get '/visit' do
  @client = Client.new
  @client.save

  erb :visit
end

post '/visit' do

  c = Client.new params[:client]
  if c.save
   erb "<h2>Спасибо, вы записаны.</h2>"
  else
    @error = c.errors.full_messages.first

    erb :visit
  end

end
