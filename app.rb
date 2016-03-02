require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'pry'
require 'open-uri'
require "sinatra/json"
require './image_uploader.rb'
require 'bcrypt'
require './models/bbs.rb'


enable :sessions


get '/' do
    if session[:user]
        @contents = Contribution.order('id desc').all
        @username = User.find(session[:user]).username
        erb :index
    else
        erb :cover
    end
end

get '/signin' do
    erb :signin
end

get '/signin_do' do
    erb :signin_do
end

get '/signup' do
    erb :signup
end

get '/signup_do' do
    erb :signup_do
end

post '/signin' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
        session[:name] = user.username
        redirect '/'
    else
        redirect '/signin_do'
        # render '/signin_do'
    end
end

post '/signup' do
    @user = User.create({
        username: params[:username],
        email: params[:email],
        password: params[:password]
    })
    
    if @user.persisted?
        session[:user] = @user.id
        session[:name] = @user.username
    end
    
    unless @user.save
        # @user.errors
        redirect '/signup_do'
        # render '/signup_do'
        return
    end
    
    redirect '/'
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end

post '/new' do
    @latest_post = Contribution.create({
        item_name: params[:item_name],
        comment: params[:comment],
        img: "",
        good: 0,
        user_id: session[:user]
    })
    
    if params[:file]
        image_upload(params[:file])
    # else if params[:url]
        # Cloudinary::Uploader.upload(params[:url], :public_id => 'sample_remote')
    end
    
    redirect '/'
end

post '/delete/:id' do
    Contribution.find(params[:id]).destroy
    redirect '/'
end

post '/edit' do
    @contents = Contribution.where(user_id: session[:user]).order('id desc')
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
    @contents = Contribution.where(user_id: params[:user_id]).order('id desc')
    erb :personal
end

get '/upload_from_extension' do
    if session[:user]
        @contents = Contribution.order('id desc').all
        @username = User.find(session[:user]).username
        erb :index
    else
        redirect "/signin"
    end
end