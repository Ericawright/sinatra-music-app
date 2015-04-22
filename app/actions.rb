enable :sessions
# set :session_secret, '(*ArvinderKang*&'


get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  erb :'songs/new'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    artist:  params[:artist],
    url:   params[:url],
    user_id: session[:user_id]
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

##############################################################################

get '/users/new' do
  erb :'users/new'
end

post '/users/new' do
  @user = User.new(
    username: params[:username],
    password:  params[:password]
  )
  if @user.save
    @current_user = User.where(username: params[:username], password:  params[:password]).first
    session[:user_id] = @current_user.id
    redirect 'users/profile'
  else
    erb :'user/new'
  end
end

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  @current_user = User.where(username: params[:username], password:  params[:password]).first
  session[:user_id] = @current_user.id
  redirect '/users/profile'
end

get '/users/profile' do
  @current_user = User.where(id: session[:user_id]).first
  erb :'users/profile'
end

get '/users/logout' do 
  session.clear
  redirect to("/")
end


 


 

 

 

 
# get '/submit' do
#   # response.set_cookie('test', 'MadeInVancouver')
#   session["user"] ||= ''
#   @name = "Arvinder Kang"
#   erb :index
#   "The cookie you've created contains the value: #{session["value"]}"
# end




