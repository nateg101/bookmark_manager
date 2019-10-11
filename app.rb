# frozen_string_literal: true

require 'sinatra/base'
require_relative './lib/bookmarks'
require './database_connection_setup'
require 'uri'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    'Bookmark Manager'
    # erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmarks.all
    erb(:bookmarks)
  end

  post '/bookmarks' do
    flash[:notice] = "Submit a valid URL please babe." unless Bookmarks.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmarks.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/update' do
    @bookmark = Bookmarks.find(id: params[:id])
    erb :'bookmarks/update'
  end

  patch '/bookmarks/:id' do
    Bookmarks.update(id: params[:id], url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  get '/bookmarks/new' do
    erb(:"bookmarks/new")
  end

  run! if app_file == $PROGRAM_NAME
end
