CREATE TABLE country (
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE league (
	id INT NOT NULL PRIMARY KEY,
	country_id INT NOT NULL,
	name VARCHAR(255) NOT NULL,
	
	CONSTRAINT FK_country
	FOREIGN KEY(country_id)
	REFERENCES country(id)
);

CREATE TABLE player(
	id INT NOT NULL,
	player_api_id VARCHAR(255) NOT NULL PRIMARY KEY,
	player_name VARCHAR(255) NOT NULL,
	player_fifa_api_id INT  NOT NULL,
	birthday DATE NOT NULL,
	height FLOAT(2) NOT NULL,
	weight FLOAT(2) NOT NULL
);

CREATE TABLE player_attributes(
    id INT NOT NULL PRIMARY KEY,
    player_api_id VARCHAR(255) NOT NULL,
    player_fifa_api_id INT  NOT NULL,
    date DATE NOT NULL,
    overall_rating VARCHAR(10)  NOT NULL,
    potential VARCHAR(10)  NOT NULL,
    preferred_foot VARCHAR(6) NOT NULL,
    attacking_work_rate VARCHAR(8),
    defensive_work_rate VARCHAR(8),
    crossing VARCHAR(10)  NOT NULL,
    finishing VARCHAR(10)  NOT NULL,
    heading_accuracy VARCHAR(10)  NOT NULL,
    short_passing VARCHAR(10)  NOT NULL,
    volleys VARCHAR(10)  NOT NULL,
    dribbling VARCHAR(10)  NOT NULL,
    curve VARCHAR(10)  NOT NULL,
    free_kick_accuracy VARCHAR(10)  NOT NULL,
    long_passing VARCHAR(10)  NOT NULL,
    ball_control VARCHAR(10)  NOT NULL,
    acceleration VARCHAR(10)  NOT NULL,
    sprint_speed VARCHAR(10)  NOT NULL,
    agility VARCHAR(10)  NOT NULL,
    reactions VARCHAR(10)  NOT NULL,
    balance VARCHAR(10)  NOT NULL,
    shot_power VARCHAR(10)  NOT NULL,
    jumping VARCHAR(10)  NOT NULL,
    stamina VARCHAR(10)  NOT NULL,
    strength VARCHAR(10)  NOT NULL,
    long_shots VARCHAR(10)  NOT NULL,
    aggression VARCHAR(10)  NOT NULL,
    interceptions VARCHAR(10)  NOT NULL,
    positioning VARCHAR(10)  NOT NULL,
    vision VARCHAR(10)  NOT NULL,
    penalties VARCHAR(10)  NOT NULL,
    marking VARCHAR(10)  NOT NULL,
    standing_tackle VARCHAR(10)  NOT NULL,
    sliding_tackle VARCHAR(10)  NOT NULL,
    gk_diving VARCHAR(10)  NOT NULL,
    gk_handling VARCHAR(10)  NOT NULL,
    gk_kicking VARCHAR(10)  NOT NULL,
    gk_positioning VARCHAR(10)  NOT NULL,
    gk_reflexes VARCHAR(10)  NOT NULL,
	
	CONSTRAINT FK_player
	FOREIGN KEY(player_api_id)
	REFERENCES player (player_api_id)
);
	
CREATE TABLE team (
    id INT NOT NULL,
    team_api_id INT NOT NULL PRIMARY KEY,
    team_fifa_api_id VARCHAR(10) NOT NULL,
    team_long_name VARCHAR(255) NOT NULL,
    team_short_name VARCHAR(255) NOT NULL
);

CREATE TABLE team_attributes (
    id INT NOT NULL PRIMARY KEY,
    team_fifa_api_id INT NOT NULL,
    team_api_id INT NOT NULL,
    date DATE NOT NULL,
    buildUpPlaySpeed VARCHAR(20) NOT NULL,
    buildUpPlaySpeedClass VARCHAR(20) NOT NULL,
    buildUpPlayDribbling VARCHAR(20) NOT NULL,
    buildUpPlayDribblingClass VARCHAR(20) NOT NULL,
    buildUpPlayPassing VARCHAR(20) NOT NULL,
    buildUpPlayPassingClass VARCHAR(20) NOT NULL,
    buildUpPlayPositioningClass VARCHAR(20) NOT NULL,
    chanceCreationPassing VARCHAR(20) NOT NULL,
    chanceCreationPassingClass VARCHAR(20) NOT NULL,
    chanceCreationCrossing VARCHAR(20) NOT NULL,
    chanceCreationCrossingClass VARCHAR(20) NOT NULL,
    chanceCreationShooting VARCHAR(20) NOT NULL,
    chanceCreationShootingClass VARCHAR(20) NOT NULL,
    chanceCreationPositioningClass VARCHAR(20) NOT NULL,
    defencePressure VARCHAR(20) NOT NULL,
    defencePressureClass VARCHAR(20) NOT NULL,
    defenceAggression VARCHAR(20) NOT NULL,
    defenceAggressionClass VARCHAR(20) NOT NULL,
    defenceTeamWidth VARCHAR(20) NOT NULL,
    defenceTeamWidthClass VARCHAR(20) NOT NULL,
    defenceDefenderLineClass VARCHAR(20) NOT NULL,
	
	CONSTRAINT FK_team
	FOREIGN KEY(team_api_id)
	REFERENCES team (team_api_id)
);
	
CREATE TABLE match(
	id INT NOT NULL PRIMARY KEY,
	country_id INT  NOT NULL,
	league_id INT  NOT NULL,
	season VARCHAR(255) NOT NULL,
	stage VARCHAR(255) NOT NULL,
	date DATE NOT NULL,
	match_api_id INT  NOT NULL,
	home_team_api_id INT  NOT NULL,
	away_team_api_id INT  NOT NULL,
	home_team_goal VARCHAR(10)  NOT NULL,
	away_team_goal VARCHAR(10)  NOT NULL,
	home_player_X1 VARCHAR(10)  NOT NULL,
	home_player_X2 VARCHAR(10)  NOT NULL,
	home_player_X3 VARCHAR(10)  NOT NULL,
	home_player_X4 VARCHAR(10)  NOT NULL,
	home_player_X5 VARCHAR(10)  NOT NULL,
	home_player_X6 VARCHAR(10)  NOT NULL,
	home_player_X7 VARCHAR(10)  NOT NULL,
	home_player_X8 VARCHAR(10)  NOT NULL,
	home_player_X9 VARCHAR(10)  NOT NULL,
	home_player_X10 VARCHAR(10)  NOT NULL,
	home_player_X11 VARCHAR(10)  NOT NULL,
	away_player_X1 VARCHAR(10)  NOT NULL,
	away_player_X2 VARCHAR(10)  NOT NULL,
	away_player_X3 VARCHAR(10)  NOT NULL,
	away_player_X4 VARCHAR(10)  NOT NULL,
	away_player_X5 VARCHAR(10)  NOT NULL,
	away_player_X6 VARCHAR(10)  NOT NULL,
	away_player_X7 VARCHAR(10)  NOT NULL,
	away_player_X8 VARCHAR(10)  NOT NULL,
	away_player_X9 VARCHAR(10)  NOT NULL,
	away_player_X10 VARCHAR(10)  NOT NULL,
	away_player_X11 VARCHAR(10)  NOT NULL,
	home_player_Y1 VARCHAR(10)  NOT NULL,
	home_player_Y2 VARCHAR(10)  NOT NULL,
	home_player_Y3 VARCHAR(10)  NOT NULL,
	home_player_Y4 VARCHAR(10)  NOT NULL,
	home_player_Y5 VARCHAR(10)  NOT NULL,
	home_player_Y6 VARCHAR(10)  NOT NULL,
	home_player_Y7 VARCHAR(10)  NOT NULL,
	home_player_Y8 VARCHAR(10)  NOT NULL,
	home_player_Y9 VARCHAR(10)  NOT NULL,
	home_player_Y10 VARCHAR(10)  NOT NULL,
	home_player_Y11 VARCHAR(10)  NOT NULL,
	away_player_Y1 VARCHAR(10)  NOT NULL,
	away_player_Y2 VARCHAR(10)  NOT NULL,
	away_player_Y3 VARCHAR(10)  NOT NULL,
	away_player_Y4 VARCHAR(10)  NOT NULL,
	away_player_Y5 VARCHAR(10)  NOT NULL,
	away_player_Y6 VARCHAR(10)  NOT NULL,
	away_player_Y7 VARCHAR(10)  NOT NULL,
	away_player_Y8 VARCHAR(10)  NOT NULL,
	away_player_Y9 VARCHAR(10)  NOT NULL,
	away_player_Y10 VARCHAR(10)  NOT NULL,
	away_player_Y11 VARCHAR(10)  NOT NULL,
	home_player_1 VARCHAR(255) NOT NULL,
	home_player_2 VARCHAR(255) NOT NULL,
	home_player_3 VARCHAR(255) NOT NULL,
	home_player_4 VARCHAR(255) NOT NULL,
	home_player_5 VARCHAR(255) NOT NULL,
	home_player_6 VARCHAR(255) NOT NULL,
	home_player_7 VARCHAR(255) NOT NULL,
	home_player_8 VARCHAR(255) NOT NULL,
	home_player_9 VARCHAR(255) NOT NULL,
	home_player_10 VARCHAR(255) NOT NULL,
	home_player_11 VARCHAR(255) NOT NULL,
	away_player_1 VARCHAR(255) NOT NULL,
	away_player_2 VARCHAR(255) NOT NULL,
	away_player_3 VARCHAR(255) NOT NULL,
	away_player_4 VARCHAR(255) NOT NULL,
	away_player_5 VARCHAR(255) NOT NULL,
	away_player_6 VARCHAR(255) NOT NULL,
	away_player_7 VARCHAR(255) NOT NULL,
	away_player_8 VARCHAR(255) NOT NULL,
	away_player_9 VARCHAR(255) NOT NULL,
	away_player_10 VARCHAR(255) NOT NULL,
	away_player_11 VARCHAR(255) NOT NULL,
	goal TEXT NOT NULL,
	shoton TEXT NOT NULL,
	shotoff TEXT NOT NULL,
	foulcommit TEXT NOT NULL,
	card TEXT NOT NULL,
	cross_ TEXT NOT NULL,
	corner TEXT NOT NULL,
	possession TEXT NOT NULL,
	B365H VARCHAR(255) NOT NULL,
	B365D VARCHAR(255) NOT NULL,
	B365A VARCHAR(255) NOT NULL,
	BWH VARCHAR(255) NOT NULL,
	BWD VARCHAR(255) NOT NULL,
	BWA VARCHAR(255) NOT NULL,
	IWH VARCHAR(255) NOT NULL,
	IWD VARCHAR(255) NOT NULL,
	IWA VARCHAR(255) NOT NULL,
	LBH VARCHAR(255) NOT NULL,
	LBD VARCHAR(255) NOT NULL,
	LBA VARCHAR(255) NOT NULL,
	PSH VARCHAR(255) NOT NULL,
	PSD VARCHAR(255) NOT NULL,
	PSA VARCHAR(255) NOT NULL,
	WHH VARCHAR(255) NOT NULL,
	WHD VARCHAR(255) NOT NULL,
	WHA VARCHAR(255) NOT NULL,
	SJH VARCHAR(255) NOT NULL,
	SJD VARCHAR(255) NOT NULL,
	SJA VARCHAR(255) NOT NULL,
	VCH VARCHAR(255) NOT NULL,
	VCD VARCHAR(255) NOT NULL,
	VCA VARCHAR(255) NOT NULL,
	GBH VARCHAR(255) NOT NULL, 
	GBD VARCHAR(255) NOT NULL,
	GBA VARCHAR(255) NOT NULL,
	BSH VARCHAR(255) NOT NULL,
	BSD VARCHAR(255) NOT NULL,
	BSA VARCHAR(255) NOT NULL,
	
	CONSTRAINT FK_league
	FOREIGN KEY(league_id )
	REFERENCES league (id),
	
	CONSTRAINT FK_home_team
	FOREIGN KEY(home_team_api_id )
	REFERENCES team (team_api_id),
	
	CONSTRAINT FK_away_team
	FOREIGN KEY(away_team_api_id )
	REFERENCES team (team_api_id)
);