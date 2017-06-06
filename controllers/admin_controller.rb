require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/player')
require_relative('../models/game')
require_relative('../models/group')
require_relative('../models/organisation')

enable :sessions

##ADMIN
#LOG IN
get '/admin/login' do
  erb(:'admin/login', :layout => :layout_admin)
end

post '/admin/login' do
  @password = params[:password]
  if (@password == '1989')
    session[:admin] = 'admin'
    @message = "You now have Admin privileges"
  else
    @message = "Sorry, incorrect password"
  end
  erb(:'admin/login_res', :layout => :layout_admin)
end

#PLAYER
get '/admin/player/index' do
  @players = Player.all
  if (session[:admin] = 'admin')
    erb(:'admin/player/index', :layout => :layout_admin)      
  else
    redirect '/admin/login'
  end
end

get '/admin/player/:pid/update' do
  @player = Player.find_by_id(params[:pid])
  @orgs = Organisation.all()
  @groups = Group.all()  
  if (session[:admin] = 'admin')
    erb(:'admin/player/update', :layout => :layout_admin)
  else
    redirect '/admin/login'
  end
end

post '/admin/player/:pid/update' do
  @player = Player.new(params)
  @player.update #need to write this method and needs to update join tables
  redirect '/admin/player/index'
end

post '/admin/player/:pid/delete' do
  if (session[:admin] = 'admin')
    Player.delete(params[:pid])
    redirect 'admin/player/index'
  else
    redirect '/admin/login'
  end
end

#GAME
get '/admin/game/index' do
  @games = Game.all
    if (session[:admin] = 'admin')
      erb(:'admin/game/index', :layout => :layout_admin)      
    else
      redirect '/admin/login'
    end
  end
