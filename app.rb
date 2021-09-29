#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, { adapter: "sqlite3", database: "barbershop.db" }

class Client < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  validates :phone, presence: true
  validates :datestamp, presence: true
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
  @c = Client.new

  @barbers = Barber.all
  erb :visit
end

post '/visit' do
  @c = Client.new params[:client]
  if @c.save
    erb "Вы успешно записались!"
  else
    @error = @c.errors.full_messages.first
      erb :visit
  end
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

get '/barber/:id' do
  @barber = Barber.find(params[:id])
  erb :barber
end

get '/booking' do
  @clients = Client.order('created_at DESC')
  erb :bookings
end