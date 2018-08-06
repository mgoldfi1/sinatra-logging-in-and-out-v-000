require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
  if User.exists?(username: params["username"], password: params["password"])
  @user = User.find_by(username: params["username"], password: params["password"])
  session[:user_id] = @user.id
  redirect to('/account')
  else
  redirect to('/login')
  end
end

  get '/account' do
    @user = User.find_by_id(session[:user_id])
    erb :account
  end

  get '/logout' do

  end


end
