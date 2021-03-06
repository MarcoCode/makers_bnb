class MakersBnb < Sinatra::Base

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users/new' do
  @user = User.new(email: params[:email],
                      password: params[:password],
                      password_confirmation: params[:password_confirmation],
                      name: params[:name],
                      username: params[:username])
  if @user.save
    session[:user_id] = @user.id
    flash[:notice] = "Welcome, #{@user.name}"
    redirect '/spaces'
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :'users/new'
  end
end

get '/users/account' do
  if current_user
    @users_spaces = Space.all(user_id: current_user.id)
    erb :'users/account'
  else
    redirect '/sessions/new'
  end
end

delete '/sessions' do
  flash[:notice] = "See you later, #{current_user.name}"
  session[:user_id] = nil
  redirect '/'
end

end
