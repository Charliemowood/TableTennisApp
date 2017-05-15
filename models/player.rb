require_relative('../db/sql_runner')

class Player

  attr_reader :id, :p_name

  def initialize(player_hash)
    @id = player_hash['id'].to_i
    @p_name = player_hash['p_name']
  end

  ### INSTANCE METHODS

  def save()
    sql = "INSERT INTO players (p_name) VALUES ('#{@p_name}') RETURNING id"
    players_array_pg = SqlRunner.run(sql)
    @id = players_array_pg.first['id'].to_i
  end

end