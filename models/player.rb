require_relative('../db/sql_runner')

class Player

  attr_reader :id, :p_name, :rating, :picture, :primary_org_id

  def initialize(player_hash)
    @id = player_hash['id'].to_i
    @p_name = player_hash['p_name']
    @rating = player_hash['rating'].to_i
    @picture = player_hash['picture']
    @primary_org_id = player_hash['primary_org_id'].to_i
    @primary_group_id = player_hash['primary_group_id'].to_i
  end

  ### INSTANCE METHODS

  def save()
    sql1 = "INSERT INTO players 
    (p_name, rating, picture, primary_org_id, primary_group_id)
     VALUES 
     ('#{@p_name}', #{@rating}, '#{@picture}', #{@primary_org_id}, #{@primary_group_id}) 
     RETURNING id"
    players_array_pg = SqlRunner.run(sql1)
    @id = players_array_pg.first['id'].to_i
    
    sql2 = "INSERT INTO pl_group_join 
    (p_id, group_id) VALUES (#{@id}, #{@primary_group_id}) "
    SqlRunner.run(sql2)

    sql3 = "INSERT INTO pl_org_join
    (p_id, org_id) VALUES (#{@id}, #{@primary_org_id})"
    SqlRunner.run(sql3)
  end

  def wins()
    sql = 
    "SELECT COUNT(id) 
    FROM games
    WHERE 
    p1_score>p2_score AND p1_id=#{self.id} 
    OR 
    p2_score>p1_score AND p2_id=#{self.id}"
    win_amount_pg = SqlRunner.run(sql)
    win_amount_int = win_amount_pg.first['count'].to_i
    return win_amount_int
  end

  def losses()
    sql = 
    "SELECT COUNT(id) 
    FROM games
    WHERE 
    p1_score<p2_score AND p1_id=#{self.id} 
    OR 
    p2_score<p1_score AND p2_id=#{self.id}"
    loss_amount_pg = SqlRunner.run(sql)
    loss_amount_int = loss_amount_pg.first['count'].to_i
    return loss_amount_int
  end

  def no_games()
    sql = "SELECT COUNT(id) FROM games 
    WHERE p1_id=#{self.id}
    OR p2_id=#{self.id}"
    no_games_pg = SqlRunner.run(sql)
    no_games_int = no_games_pg.first['count'].to_i
    return no_games_int
  end

  def win_ratio()
    ratio = ( self.wins().to_f / self.no_games ).round(4) * 100
    return ratio
  end

  def join_group(group)
    sql = "INSERT INTO pl_group_join (p_id, group_id) VALUES (#{@id}, #{group.id})"
    SqlRunner.run(sql)
  end

  def join_org(org)
    sql = "INSERT INTO pl_org_join (p_id, org_id) VALUES (#{@id}, #{org.id})"
    SqlRunner.run(sql)
  end

  ### CLASS METHODS

  def self.all()
    sql = "SELECT * FROM players"
    Player.map_players(sql)
  end

  def self.all_sorted_by_wins()
    p_ob_array = self.all
    sorted = p_ob_array.sort{|x,y| 
    y.wins <=> x.wins }
    return sorted
  end

  def self.delete(id)
    sql = "DELETE FROM players WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  ## Helper
  def self.map_players(sql)
    players_pg = SqlRunner.run(sql)
    players_objects_rb = players_pg.map{ |player| 
      Player.new(player)}
    return players_objects_rb
  end

end