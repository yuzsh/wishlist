require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
# require 'pry'
require 'open-uri'
require "sinatra/json"
require './image_uploader.rb'
require './models/bbs.rb'
require 'bcrypt'

enable :sessions


get '/' do
    unless session[:user]
        erb :cover
    else
        @contents = Contribution.order('id desc').all
        erb :index
    end
end

# get '/cover' do
#     erb :cover
# end

get '/signin' do
    erb :signin
end

get '/signup' do
    erb :signup
end

post '/signin' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    
    redirect '/'
end

post '/signup' do
    @user = User.create({
        username: params[:username],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
    })
    
    if @user.persisted?
        session[:user] = @user.id
    end
    
    redirect '/'
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end

post '/new' do
    Contribution.create({
        item_name: params[:item_name],
        comment: params[:comment],
        img: "",
        good: 0,
        username: User.find(session[:user]).username
    })
    
    if params[:file]
        image_upload(params[:file])
    end
    
    redirect '/'
end

post '/delete/:id' do
    Contribution.find(params[:id]).destroy
    redirect '/'
end

post '/edit' do
    @contents = Contribution.order('id desc').all
    erb :edit
end

post '/edit/:id' do
    @content = Contribution.find(params[:id])
    erb :edit_id
end

post '/renew/:id' do
    @content = Contribution.find(params[:id])
    @content.update({
        item_name: params[:item_name],
        comment: params[:comment]
    })
    redirect '/'
end

post '/good/:id' do
    @content = Contribution.find(params[:id])
    good = @content.good
    @content.update({
        good: good + 1
    })
    redirect '/'
end

post '/want/:id' do
    @content = Contribution.find(params[:id])
    want = @content.want
    @content.update({
        want: want + 1
    })
    redirect '/'
end

post '/back' do
    redirect '/'
end

get '/user/:user_id' do
    # Userテーブルからユーザ名取得
    name = User.where(id: params[:user_id]).first.username
    @contents = Contribution.where(username: name)
    erb :personal
end