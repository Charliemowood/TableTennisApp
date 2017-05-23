require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/player')
require_relative('../models/game')
require_relative('../models/group')
require_relative('../models/organisation')
require_relative('../models/location')

# GAME

get '/game/new' do
  @players = Player.all
  @organisations = Organisation.all
  @groups = Group.all
  @locations = Location.all
  erb(:'game/new')
end

post '/game/new/result' do
  @new_result = Game.new(params)
  @new_result.save
  redirect '/'
end
