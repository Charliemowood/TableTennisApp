DROP TABLE IF EXISTS pl_org_join CASCADE;
DROP TABLE IF EXISTS pl_group_join CASCADE;
DROP TABLE IF EXISTS games CASCADE;
DROP FUNCTION IF EXISTS calculate_winner();
DROP FUNCTION IF EXISTS find_primary_org();
DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS groups CASCADE;
DROP TABLE IF EXISTS organisations;
DROP TABLE IF EXISTS locations;



CREATE TABLE locations(
  id SERIAL2 PRIMARY KEY,
  l_name VARCHAR(255)
);

CREATE TABLE organisations(
  id SERIAL2 PRIMARY KEY,
  o_name VARCHAR(255)
);

CREATE TABLE groups(
  id SERIAL2 PRIMARY KEY,
  g_name VARCHAR(255),
  org_id INT4 REFERENCES organisations(id) ON DELETE CASCADE
);

CREATE TABLE players(
  id SERIAL2 PRIMARY KEY,
  p_name VARCHAR(255),
  rating INT4,
  picture VARCHAR(255),
  primary_org_id INT4 REFERENCES organisations(id) ON DELETE CASCADE,
  primary_group_id INT4 REFERENCES groups(id) ON DELETE CASCADE
);

CREATE TABLE games(
  id SERIAL2 PRIMARY KEY,
  p1_id INT4 REFERENCES players(id) ON DELETE CASCADE,
  p2_id INT4 REFERENCES players(id) ON DELETE CASCADE,
  p1_score INT4,
  p2_score INT4,
  winner_id INT4,
  tstamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP(2),
  p1_org_id INT4 REFERENCES organisations(id) ON DELETE CASCADE,
  p2_org_id INT4 REFERENCES organisations(id) ON DELETE CASCADE,
  p1_group_id INT4 REFERENCES groups(id) ON DELETE CASCADE,
  p2_group_id INT4 REFERENCES groups(id) ON DELETE CASCADE,
  location_id INT4 REFERENCES locations(id) ON DELETE CASCADE
);

CREATE TABLE pl_group_join(
  id SERIAL2 PRIMARY KEY,
  p_id INT4 REFERENCES players(id) ON DELETE CASCADE,
  group_id INT4 REFERENCES groups(id) ON DELETE CASCADE
);

CREATE TABLE pl_org_join(
  id SERIAL2 PRIMARY KEY,
  p_id INT4 REFERENCES players(id) ON DELETE CASCADE,
  org_id INT4 REFERENCES groups(id) ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION calculate_winner()
RETURNS TRIGGER AS $d$
BEGIN
IF NEW.p1_score > NEW.p2_score THEN
   NEW.winner_id = NEW.p1_id;
ELSIF NEW.p1_score < NEW.p2_score THEN
  NEW.winner_id = NEW.p2_id;
ELSE
 NEW.winner_id = 0;
END IF;

RETURN NEW;
END;
$d$ LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION find_primary_org()
-- RETURNS INT4 AS $d$
-- BEGIN

-- SELECT p1_id FROM games WHERE id = 1;
-- RETURN p1_id;
-- END;
-- $d$ LANGUAGE plpgsql;

CREATE TRIGGER determine_winner 
BEFORE INSERT ON games
FOR EACH ROW 
EXECUTE PROCEDURE calculate_winner();

-- SELECT find_primary_org()
