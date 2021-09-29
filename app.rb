#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, { adapter: "sqlite3", database: "barbershop.db" }

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

get '/' do
  @barbers = Barber.order "created_at DESC"
  erb :index
end

get '/visit' do
  @barbers = Barber.all
  erb :visit
end

post '/visit' do
  c = Client.new params[:client]
  c.save

  erb "Вы успешно записались!"
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
  @email = params[:email]
  @message = params[:message]

  Contact.create :email => @email, :message => @message

  erb "Ваше сообщение успешно отправлено"
end