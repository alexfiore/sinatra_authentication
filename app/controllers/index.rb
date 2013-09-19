get '/' do
  @users = User.all
  erb :index
end

get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  p params
  if User.authenticate(params[:email], params[:password])
    @user_now = User.find_by_email(params[:email])
    session[:id] = @user_now.id
    redirect '/'
  else
    redirect '/'
  end
end

delete '/sessions/:id' do
  session.clear
  redirect '/'
end

get '/users/new' do
  erb :sign_up
end

post '/users' do
  @new_user = User.new(params[:user])
  if @new_user.save
    session[:id] = @new_user.id
    redirect '/'
  else
    @errors = @new_user.errors.messages
    erb :sign_up
  end
end
