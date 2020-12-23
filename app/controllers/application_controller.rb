require_relative '../../config/environment'

# Main controller
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/articles'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    Article.create(params)
    redirect "/articles/#{Article.all.last.id}"
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    Article.find(params[:id]).update(title: params[:title], content: params[:content])
    redirect "/articles/#{params[:id]}"
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect '/'
  end

end
