/*Query 1*/
SELECT q.season,l.name as league,t.team_long_name as team,SUM(cant) as cant_total
FROM (SELECT season,COUNT(*) as cant,league_id,home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,home_team_api_id
	  UNION ALL
	  SELECT season,COUNT(*) as cant,league_id,away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,away_team_api_id) as q
	  INNER JOIN league l ON q.league_id = l.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
GROUP BY q.season,l.id,t.team_api_id
ORDER BY season ASC;

/*Query 2*/
SELECT *
FROM
(SELECT q.season,l.name as league,t.team_long_name as team,SUM(goal_difference) as goal_difference_total,
RANK() OVER (PARTITION BY q.season,l.id ORDER BY SUM(goal_difference) DESC) AS Rank
FROM (SELECT season,SUM(home_team_goal::INT) as favor_goals, SUM(away_team_goal::INT) as against_goals,
	  (SUM(home_team_goal::INT) - SUM(away_team_goal::INT)) as goal_difference, league_id,
	  home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,home_team_api_id
	  UNION ALL
	  SELECT season,SUM(away_team_goal::INT) as favor_goals, SUM(home_team_goal::INT) as against_goals,
	  (SUM(away_team_goal::INT) - SUM(home_team_goal::INT)) as goal_difference, league_id,
	  away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,away_team_api_id) as q
	  INNER JOIN league l ON q.league_id = l.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
GROUP BY q.season,l.id,t.team_api_id
ORDER BY Rank, season ASC) as q_f
WHERE Rank = 1

/*Query 3*/
WITH match_ as (SELECT
	   id,country_id,league_id,season,stage,date,match_api_id,home_team_api_id,away_team_api_id,
			home_team_goal,away_team_goal,home_player_X1,home_player_X2,home_player_X3,
			home_player_X4,home_player_X5,home_player_X6,home_player_X7,home_player_X8,
			home_player_X9,home_player_X10,home_player_X11,away_player_X1,away_player_X2,
			away_player_X3,away_player_X4,away_player_X5,away_player_X6,away_player_X7,
			away_player_X8,away_player_X9,away_player_X10,away_player_X11,home_player_Y1,
			home_player_Y2,home_player_Y3,home_player_Y4,home_player_Y5,home_player_Y6,
			home_player_Y7,home_player_Y8,home_player_Y9,home_player_Y10,home_player_Y11,
			away_player_Y1,away_player_Y2,away_player_Y3,away_player_Y4,away_player_Y5,
			away_player_Y6,away_player_Y7,away_player_Y8,away_player_Y9,away_player_Y10,
			away_player_Y11,home_player_1,home_player_2,home_player_3,home_player_4,home_player_5,
			home_player_6,home_player_7,home_player_8,home_player_9,home_player_10,home_player_11,
			away_player_1,away_player_2,away_player_3,away_player_4,away_player_5,away_player_6,
			away_player_7,away_player_8,away_player_9,away_player_10,away_player_11,goal,shoton,
			shotoff,foulcommit,card,cross_,corner,possession,
	(B365H::FLOAT),
	(B365A::FLOAT),
	(BWH::FLOAT),
	(BWA::FLOAT),
	(IWH::FLOAT),
	(IWA::FLOAT),
	(LBH::FLOAT),
	(LBA::FLOAT),
	(PSH::FLOAT),
	(PSA::FLOAT),
	(WHH::FLOAT),
	(WHA::FLOAT),
	(SJH::FLOAT),
	(SJA::FLOAT),
	(VCH::FLOAT),
	(VCA::FLOAT),
	(GBH::FLOAT), 
	(GBA::FLOAT),
	(BSH::FLOAT),
	(BSA::FLOAT)
FROM (SELECT
	   id,country_id,league_id,season,stage,date,match_api_id,home_team_api_id,away_team_api_id,
				home_team_goal,away_team_goal,home_player_X1,home_player_X2,home_player_X3,
				home_player_X4,home_player_X5,home_player_X6,home_player_X7,home_player_X8,
				home_player_X9,home_player_X10,home_player_X11,away_player_X1,away_player_X2,
				away_player_X3,away_player_X4,away_player_X5,away_player_X6,away_player_X7,
				away_player_X8,away_player_X9,away_player_X10,away_player_X11,home_player_Y1,
				home_player_Y2,home_player_Y3,home_player_Y4,home_player_Y5,home_player_Y6,
				home_player_Y7,home_player_Y8,home_player_Y9,home_player_Y10,home_player_Y11,
				away_player_Y1,away_player_Y2,away_player_Y3,away_player_Y4,away_player_Y5,
				away_player_Y6,away_player_Y7,away_player_Y8,away_player_Y9,away_player_Y10,
				away_player_Y11,home_player_1,home_player_2,home_player_3,home_player_4,home_player_5,
				home_player_6,home_player_7,home_player_8,home_player_9,home_player_10,home_player_11,
				away_player_1,away_player_2,away_player_3,away_player_4,away_player_5,away_player_6,
				away_player_7,away_player_8,away_player_9,away_player_10,away_player_11,goal,shoton,
				shotoff,foulcommit,card,cross_,corner,possession,
	  (CASE
	  WHEN(B365H ='') THEN NULL
	  ELSE B365H
	  END) as B365H,
	  (CASE
	  WHEN(B365D ='') THEN NULL
	  ELSE B365D
	  END) as B365D,
	  (CASE
	  WHEN(B365A ='') THEN NULL
	  ELSE B365A
	  END) as B365A,
	  (CASE
	  WHEN(BWH ='') THEN NULL
	  ELSE BWH
	  END) as BWH,
	  (CASE
	  WHEN(BWD ='') THEN NULL
	  ELSE BWD
	  END) as BWD,
	  (CASE
	  WHEN(BWA ='') THEN NULL
	  ELSE BWA
	  END) as BWA,
	  (CASE
	  WHEN(IWH ='') THEN NULL
	  ELSE IWH
	  END) as IWH,
	  (CASE
	  WHEN(IWD ='') THEN NULL
	  ELSE IWD
	  END) as IWD,
	  (CASE
	  WHEN(IWA ='') THEN NULL
	  ELSE IWA
	  END) as IWA,
	  (CASE
	  WHEN(LBH ='') THEN NULL
	  ELSE LBH
	  END) as LBH,
	  (CASE
	  WHEN(LBD ='') THEN NULL
	  ELSE LBD
	  END) as LBD,
	  (CASE
	  WHEN(LBA ='') THEN NULL
	  ELSE LBA
	  END) as LBA,
	  (CASE
	  WHEN(PSH ='') THEN NULL
	  ELSE PSH
	  END) as PSH,
	  (CASE
	  WHEN(PSD ='') THEN NULL
	  ELSE PSD
	  END) as PSD,
	  (CASE
	  WHEN(PSA ='') THEN NULL
	  ELSE PSA
	  END) as PSA,
	  (CASE
	  WHEN(WHH ='') THEN NULL
	  ELSE WHH
	  END) as WHH,
	  (CASE
	  WHEN(WHD ='') THEN NULL
	  ELSE WHD
	  END) as WHD,
	  (CASE
	  WHEN(WHA ='') THEN NULL
	  ELSE WHA
	  END) as WHA,
	  (CASE
	  WHEN(SJH ='') THEN NULL
	  ELSE SJH
	  END) as SJH,
	  (CASE
	  WHEN(SJD ='') THEN NULL
	  ELSE SJD
	  END) as SJD,
	  (CASE
	  WHEN(SJA ='') THEN NULL
	  ELSE SJA
	  END) as SJA,
	  (CASE
	  WHEN(VCH ='') THEN NULL
	  ELSE VCH
	  END) as VCH,
	  (CASE
	  WHEN(VCD ='') THEN NULL
	  ELSE VCD
	  END) as VCD,
	  (CASE
	  WHEN(VCA ='') THEN NULL
	  ELSE VCA
	  END) as VCA,
	  (CASE
	  WHEN(GBH ='') THEN NULL
	  ELSE GBH
	  END) as GBH,
	  (CASE
	  WHEN(GBD ='') THEN NULL
	  ELSE GBD
	  END) as GBD,
	  (CASE
	  WHEN(GBA ='') THEN NULL
	  ELSE GBA
	  END) as GBA,
	  (CASE
	  WHEN(BSH ='') THEN NULL
	  ELSE BSH
	  END) as BSH,
	  (CASE
	  WHEN(BSD ='') THEN NULL
	  ELSE BSD
	  END) as BSD,
	  (CASE
	  WHEN(BSA ='') THEN NULL
	  ELSE BSA
	  END) as BSA
	  FROM match) as q)

SELECT q.season,l.name as league,t.team_long_name as team,
		100/AVG(B365) as B365_avg,
		100/AVG(BW) as BW_avg,
		100/AVG(IW) as IW_avg,
		100/AVG(LB) as LB_avg,
		100/AVG(PS) as PS_avg,
		100/AVG(WH) as WH_avg,
		100/AVG(SJ) as SJ_avg,
		100/AVG(VC) as VC_avg,
		100/AVG(GB) as GB_avg,
		100/AVG(BS) as BS_avg
FROM (SELECT
		season,
		league_id,
		home_team_api_id as team_api_id,
		AVG(B365H) as B365,
		AVG(BWH) as BW,
		AVG(IWH) as IW,
		AVG(LBH) as LB,
		AVG(PSH) as PS,
		AVG(WHH) as WH,
		AVG(SJH) as SJ,
		AVG(VCH) as VC,
		AVG(GBH) as GB,
		AVG(BSH) as BS
	FROM match_
	GROUP BY season,league_id,home_team_api_id
	HAVING AVG(B365H) IS NOT NULL OR AVG(BWH) IS NOT NULL OR AVG(IWH) IS NOT NULL OR
	AVG(LBH) IS NOT NULL OR AVG(PSH) IS NOT NULL OR AVG(WHH) IS NOT NULL OR AVG(SJH) IS NOT NULL
	OR AVG(VCH) IS NOT NULL OR AVG(GBH) IS NOT NULL OR AVG(BSH) IS NOT NULL
	UNION ALL
	SELECT
		season,
		league_id,
		away_team_api_id as team_api_id,
		AVG(B365A) as B365,
		AVG(BWA) as BW,
		AVG(IWA) as IW,
		AVG(LBA) as LB,
		AVG(PSA) as PS,
		AVG(WHA) as WH,
		AVG(SJA) as SJ,
		AVG(VCA) as VC,
		AVG(GBA) as GB,
		AVG(BSA) as BS
	FROM match_
	GROUP BY season,league_id,away_team_api_id
	HAVING AVG(B365A) IS NOT NULL OR AVG(BWA) IS NOT NULL OR AVG(IWA) IS NOT NULL OR
	AVG(LBA) IS NOT NULL OR AVG(PSA) IS NOT NULL OR AVG(WHA) IS NOT NULL OR AVG(SJA) IS NOT NULL
	OR AVG(VCA) IS NOT NULL OR AVG(GBA) IS NOT NULL OR AVG(BSA) IS NOT NULL) as q
	INNER JOIN league l ON q.league_id = l.id
	INNER JOIN team t ON q.team_api_id = t.team_api_id
GROUP BY q.season,l.id,t.team_api_id
ORDER BY season ASC;

/*Query 4*/
WITH match_ as (SELECT
	   id,country_id,league_id,season,stage,date,match_api_id,home_team_api_id,away_team_api_id,
			home_team_goal,away_team_goal,home_player_X1,home_player_X2,home_player_X3,
			home_player_X4,home_player_X5,home_player_X6,home_player_X7,home_player_X8,
			home_player_X9,home_player_X10,home_player_X11,away_player_X1,away_player_X2,
			away_player_X3,away_player_X4,away_player_X5,away_player_X6,away_player_X7,
			away_player_X8,away_player_X9,away_player_X10,away_player_X11,home_player_Y1,
			home_player_Y2,home_player_Y3,home_player_Y4,home_player_Y5,home_player_Y6,
			home_player_Y7,home_player_Y8,home_player_Y9,home_player_Y10,home_player_Y11,
			away_player_Y1,away_player_Y2,away_player_Y3,away_player_Y4,away_player_Y5,
			away_player_Y6,away_player_Y7,away_player_Y8,away_player_Y9,away_player_Y10,
			away_player_Y11,home_player_1,home_player_2,home_player_3,home_player_4,home_player_5,
			home_player_6,home_player_7,home_player_8,home_player_9,home_player_10,home_player_11,
			away_player_1,away_player_2,away_player_3,away_player_4,away_player_5,away_player_6,
			away_player_7,away_player_8,away_player_9,away_player_10,away_player_11,goal,shoton,
			shotoff,foulcommit,card,cross_,corner,possession,
	(B365H::FLOAT),
	(B365A::FLOAT),
	(BWH::FLOAT),
	(BWA::FLOAT),
	(IWH::FLOAT),
	(IWA::FLOAT),
	(LBH::FLOAT),
	(LBA::FLOAT),
	(PSH::FLOAT),
	(PSA::FLOAT),
	(WHH::FLOAT),
	(WHA::FLOAT),
	(SJH::FLOAT),
	(SJA::FLOAT),
	(VCH::FLOAT),
	(VCA::FLOAT),
	(GBH::FLOAT), 
	(GBA::FLOAT),
	(BSH::FLOAT),
	(BSA::FLOAT)
FROM (SELECT
	   id,country_id,league_id,season,stage,date,match_api_id,home_team_api_id,away_team_api_id,
				home_team_goal,away_team_goal,home_player_X1,home_player_X2,home_player_X3,
				home_player_X4,home_player_X5,home_player_X6,home_player_X7,home_player_X8,
				home_player_X9,home_player_X10,home_player_X11,away_player_X1,away_player_X2,
				away_player_X3,away_player_X4,away_player_X5,away_player_X6,away_player_X7,
				away_player_X8,away_player_X9,away_player_X10,away_player_X11,home_player_Y1,
				home_player_Y2,home_player_Y3,home_player_Y4,home_player_Y5,home_player_Y6,
				home_player_Y7,home_player_Y8,home_player_Y9,home_player_Y10,home_player_Y11,
				away_player_Y1,away_player_Y2,away_player_Y3,away_player_Y4,away_player_Y5,
				away_player_Y6,away_player_Y7,away_player_Y8,away_player_Y9,away_player_Y10,
				away_player_Y11,home_player_1,home_player_2,home_player_3,home_player_4,home_player_5,
				home_player_6,home_player_7,home_player_8,home_player_9,home_player_10,home_player_11,
				away_player_1,away_player_2,away_player_3,away_player_4,away_player_5,away_player_6,
				away_player_7,away_player_8,away_player_9,away_player_10,away_player_11,goal,shoton,
				shotoff,foulcommit,card,cross_,corner,possession,
	  (CASE
	  WHEN(B365H ='') THEN NULL
	  ELSE B365H
	  END) as B365H,
	  (CASE
	  WHEN(B365D ='') THEN NULL
	  ELSE B365D
	  END) as B365D,
	  (CASE
	  WHEN(B365A ='') THEN NULL
	  ELSE B365A
	  END) as B365A,
	  (CASE
	  WHEN(BWH ='') THEN NULL
	  ELSE BWH
	  END) as BWH,
	  (CASE
	  WHEN(BWD ='') THEN NULL
	  ELSE BWD
	  END) as BWD,
	  (CASE
	  WHEN(BWA ='') THEN NULL
	  ELSE BWA
	  END) as BWA,
	  (CASE
	  WHEN(IWH ='') THEN NULL
	  ELSE IWH
	  END) as IWH,
	  (CASE
	  WHEN(IWD ='') THEN NULL
	  ELSE IWD
	  END) as IWD,
	  (CASE
	  WHEN(IWA ='') THEN NULL
	  ELSE IWA
	  END) as IWA,
	  (CASE
	  WHEN(LBH ='') THEN NULL
	  ELSE LBH
	  END) as LBH,
	  (CASE
	  WHEN(LBD ='') THEN NULL
	  ELSE LBD
	  END) as LBD,
	  (CASE
	  WHEN(LBA ='') THEN NULL
	  ELSE LBA
	  END) as LBA,
	  (CASE
	  WHEN(PSH ='') THEN NULL
	  ELSE PSH
	  END) as PSH,
	  (CASE
	  WHEN(PSD ='') THEN NULL
	  ELSE PSD
	  END) as PSD,
	  (CASE
	  WHEN(PSA ='') THEN NULL
	  ELSE PSA
	  END) as PSA,
	  (CASE
	  WHEN(WHH ='') THEN NULL
	  ELSE WHH
	  END) as WHH,
	  (CASE
	  WHEN(WHD ='') THEN NULL
	  ELSE WHD
	  END) as WHD,
	  (CASE
	  WHEN(WHA ='') THEN NULL
	  ELSE WHA
	  END) as WHA,
	  (CASE
	  WHEN(SJH ='') THEN NULL
	  ELSE SJH
	  END) as SJH,
	  (CASE
	  WHEN(SJD ='') THEN NULL
	  ELSE SJD
	  END) as SJD,
	  (CASE
	  WHEN(SJA ='') THEN NULL
	  ELSE SJA
	  END) as SJA,
	  (CASE
	  WHEN(VCH ='') THEN NULL
	  ELSE VCH
	  END) as VCH,
	  (CASE
	  WHEN(VCD ='') THEN NULL
	  ELSE VCD
	  END) as VCD,
	  (CASE
	  WHEN(VCA ='') THEN NULL
	  ELSE VCA
	  END) as VCA,
	  (CASE
	  WHEN(GBH ='') THEN NULL
	  ELSE GBH
	  END) as GBH,
	  (CASE
	  WHEN(GBD ='') THEN NULL
	  ELSE GBD
	  END) as GBD,
	  (CASE
	  WHEN(GBA ='') THEN NULL
	  ELSE GBA
	  END) as GBA,
	  (CASE
	  WHEN(BSH ='') THEN NULL
	  ELSE BSH
	  END) as BSH,
	  (CASE
	  WHEN(BSD ='') THEN NULL
	  ELSE BSD
	  END) as BSD,
	  (CASE
	  WHEN(BSA ='') THEN NULL
	  ELSE BSA
	  END) as BSA
	  FROM match) as q)

SELECT * FROM
(SELECT q.season,l.name as league,t.team_long_name as team,
		100/AVG(B365) as B365_avg,
		100/AVG(BW) as BW_avg,
		100/AVG(IW) as IW_avg,
		100/AVG(LB) as LB_avg,
		100/AVG(PS) as PS_avg,
		100/AVG(WH) as WH_avg,
		100/AVG(SJ) as SJ_avg,
		100/AVG(VC) as VC_avg,
		100/AVG(GB) as GB_avg,
		100/AVG(BS) as BS_avg,
		RANK() OVER (PARTITION BY q.season,l.id ORDER BY (100/AVG(B365)+100/AVG(BW)+100/AVG(IW)+
														 100/AVG(LB)+100/AVG(WH)+100/AVG(VC))/6 DESC) 
														 AS Rank
FROM (SELECT
		season,
		league_id,
		home_team_api_id as team_api_id,
		AVG(B365H) as B365,
		AVG(BWH) as BW,
		AVG(IWH) as IW,
		AVG(LBH) as LB,
		AVG(PSH) as PS,
		AVG(WHH) as WH,
		AVG(SJH) as SJ,
		AVG(VCH) as VC,
		AVG(GBH) as GB,
		AVG(BSH) as BS
	FROM match_
	GROUP BY season,league_id,home_team_api_id
	HAVING AVG(B365H) IS NOT NULL OR AVG(BWH) IS NOT NULL OR AVG(IWH) IS NOT NULL OR
	AVG(LBH) IS NOT NULL OR AVG(PSH) IS NOT NULL OR AVG(WHH) IS NOT NULL OR AVG(SJH) IS NOT NULL
	OR AVG(VCH) IS NOT NULL OR AVG(GBH) IS NOT NULL OR AVG(BSH) IS NOT NULL
	UNION ALL
	SELECT
		season,
		league_id,
		away_team_api_id as team_api_id,
		AVG(B365A) as B365,
		AVG(BWA) as BW,
		AVG(IWA) as IW,
		AVG(LBA) as LB,
		AVG(PSA) as PS,
		AVG(WHA) as WH,
		AVG(SJA) as SJ,
		AVG(VCA) as VC,
		AVG(GBA) as GB,
		AVG(BSA) as BS
	FROM match_
	GROUP BY season,league_id,away_team_api_id
	HAVING AVG(B365A) IS NOT NULL OR AVG(BWA) IS NOT NULL OR AVG(IWA) IS NOT NULL OR
	AVG(LBA) IS NOT NULL OR AVG(PSA) IS NOT NULL OR AVG(WHA) IS NOT NULL OR AVG(SJA) IS NOT NULL
	OR AVG(VCA) IS NOT NULL OR AVG(GBA) IS NOT NULL OR AVG(BSA) IS NOT NULL) as q
	INNER JOIN league l ON q.league_id = l.id
	INNER JOIN team t ON q.team_api_id = t.team_api_id
GROUP BY q.season,l.id,t.team_api_id
ORDER BY Rank,season ASC) as q_f
WHERE Rank = 1;

/*Query 5*/
SELECT * FROM
(SELECT season,l.name as league,t.team_long_name as team,player_name,overall_rating,date,
RANK() OVER (PARTITION BY season,league_id ORDER BY overall_rating DESC) AS Rank
FROM (SELECT q.season, q.league_id,q.player_name,q.team_api_id, q.player_api_id, t.overall_rating ,t.date,
	(CASE WHEN((EXTRACT('month' from t.date)::INT)>6) THEN 1 ELSE 0 END) as season_attribute,
	SUBSTRING (q.season ,1 , 4 ) as season_year_1, SUBSTRING (q.season ,6, 9 ) as season_year_2, 
	EXTRACT('year' from t.date)::TEXT as date_year
	FROM (SELECT DISTINCT player_name,player_api_id,league_id,season,
		(CASE
	  	WHEN(p.player_api_id = m.home_player_1) THEN home_team_api_id
	  	WHEN(p.player_api_id = m.home_player_2) THEN home_team_api_id
		WHEN(p.player_api_id = m.home_player_3) THEN home_team_api_id
		WHEN(p.player_api_id = m.home_player_4) THEN home_team_api_id
		WHEN(p.player_api_id = m.home_player_5) THEN home_team_api_id
		WHEN(p.player_api_id = m.home_player_6) THEN home_team_api_id
		WHEN(p.player_api_id = m.home_player_7) THEN home_team_api_id
		WHEN(p.player_api_id = m.home_player_8) THEN home_team_api_id
		WHEN(p.player_api_id = m.home_player_9) THEN home_team_api_id
		WHEN(p.player_api_id = m.home_player_10) THEN home_team_api_id
		WHEN(p.player_api_id = m.home_player_11) THEN home_team_api_id
		WHEN(p.player_api_id = m.away_player_1) THEN away_team_api_id
		WHEN(p.player_api_id = m.away_player_2) THEN away_team_api_id
		WHEN(p.player_api_id = m.away_player_3) THEN away_team_api_id
		WHEN(p.player_api_id = m.away_player_4) THEN away_team_api_id
		WHEN(p.player_api_id = m.away_player_5) THEN away_team_api_id
		WHEN(p.player_api_id = m.away_player_6) THEN away_team_api_id
		WHEN(p.player_api_id = m.away_player_7) THEN away_team_api_id
		WHEN(p.player_api_id = m.away_player_8) THEN away_team_api_id
		WHEN(p.player_api_id = m.away_player_9) THEN away_team_api_id
		WHEN(p.player_api_id = m.away_player_10) THEN away_team_api_id
		WHEN(p.player_api_id = m.away_player_11) THEN away_team_api_id
	  	END) as team_api_id
		FROM player p
			INNER JOIN match m ON p.player_api_id = m.home_player_1
					OR p.player_api_id = m.home_player_2
					OR p.player_api_id = m.home_player_3
					OR p.player_api_id = m.home_player_4
					OR p.player_api_id = m.home_player_5
					OR p.player_api_id = m.home_player_6
					OR p.player_api_id = m.home_player_7
					OR p.player_api_id = m.home_player_8
					OR p.player_api_id = m.home_player_9
					OR p.player_api_id = m.home_player_10
					OR p.player_api_id = m.home_player_11
					OR p.player_api_id = m.away_player_1
					OR p.player_api_id = m.away_player_2
					OR p.player_api_id = m.away_player_3
					OR p.player_api_id = m.away_player_4
					OR p.player_api_id = m.away_player_5
					OR p.player_api_id = m.away_player_6
					OR p.player_api_id = m.away_player_7
					OR p.player_api_id = m.away_player_8
					OR p.player_api_id = m.away_player_9
					OR p.player_api_id = m.away_player_10
					OR p.player_api_id = m.away_player_11) as q
				INNER JOIN player_attributes t ON q.player_api_id = t.player_api_id) as q1
				INNER JOIN league l ON q1.league_id = l.id
 				INNER JOIN team t ON q1.team_api_id =t.team_api_id
WHERE (season_attribute = 0 AND (season_year_2 = date_year)) OR (season_attribute = 1 AND (season_year_1 = date_year))
ORDER BY Rank, season ASC) as q_f
WHERE Rank = 1;

/*Query 6*/
SELECT * FROM
(SELECT season,l.name as league,player_name,sprint_speed,date,
RANK() OVER (PARTITION BY season ORDER BY sprint_speed DESC) AS Rank
FROM (SELECT q.season, q.league_id,q.player_name, q.player_api_id, t.sprint_speed ,t.date,
	(CASE WHEN((EXTRACT('month' from t.date)::INT)>6) THEN 1 ELSE 0 END) as season_attribute,
	SUBSTRING (q.season ,1 , 4 ) as season_year_1, SUBSTRING (q.season ,6, 9 ) as season_year_2, 
	EXTRACT('year' from t.date)::TEXT as date_year
	FROM (SELECT DISTINCT player_name,player_api_id,league_id,season
		FROM player p
			INNER JOIN match m ON p.player_api_id = m.home_player_1
					OR p.player_api_id = m.home_player_2
					OR p.player_api_id = m.home_player_3
					OR p.player_api_id = m.home_player_4
					OR p.player_api_id = m.home_player_5
					OR p.player_api_id = m.home_player_6
					OR p.player_api_id = m.home_player_7
					OR p.player_api_id = m.home_player_8
					OR p.player_api_id = m.home_player_9
					OR p.player_api_id = m.home_player_10
					OR p.player_api_id = m.home_player_11
					OR p.player_api_id = m.away_player_1
					OR p.player_api_id = m.away_player_2
					OR p.player_api_id = m.away_player_3
					OR p.player_api_id = m.away_player_4
					OR p.player_api_id = m.away_player_5
					OR p.player_api_id = m.away_player_6
					OR p.player_api_id = m.away_player_7
					OR p.player_api_id = m.away_player_8
					OR p.player_api_id = m.away_player_9
					OR p.player_api_id = m.away_player_10
					OR p.player_api_id = m.away_player_11) as q
				INNER JOIN player_attributes t ON q.player_api_id = t.player_api_id) as q1
				INNER JOIN league l ON q1.league_id = l.id
WHERE (season_attribute = 0 AND (season_year_2 = date_year)) OR (season_attribute = 1 AND (season_year_1 = date_year))
ORDER BY Rank, season ASC) as q_f
WHERE Rank IN(1,2,3,4,5,6,7,8,9,10);

/*Query 7*/
SELECT season, league, team, buildUpPlaySpeedClass, buildUpPlayDribblingClass, buildUpPlayPassingClass, buildUpPlayPositioningClass, 
	chanceCreationPassingClass, chanceCreationCrossingClass, chanceCreationShootingClass, chanceCreationPositioningClass, 
	defencePressureClass, defenceAggressionClass, defenceTeamWidthClass, defenceDefenderLineClass, date

FROM(SELECT season, league, team, t.buildUpPlaySpeedClass, t.buildUpPlayDribblingClass, t.buildUpPlayPassingClass, 
	t.buildUpPlayPositioningClass, t.chanceCreationPassingClass, t.chanceCreationCrossingClass, t.chanceCreationShootingClass, 
	t.chanceCreationPositioningClass, t.defencePressureClass, t.defenceAggressionClass, t.defenceTeamWidthClass, 
	t.defenceDefenderLineClass, t.date, (CASE WHEN((EXTRACT('month' from t.date)::INT)>6) THEN 1 ELSE 0 END) as season_attribute,
	SUBSTRING ( season ,1 , 4 ) as season_year_1, SUBSTRING ( season ,6, 9 ) as season_year_2, EXTRACT('year' from t.date)::TEXT as date_year

FROM (SELECT * FROM(SELECT q.season,l.name as league,t.team_long_name as team, t.team_api_id,SUM(match_win) as macth_win_total,
	SUM(match_lose) as macth_lose_total,SUM(match_draw) as match_draw_total,
	(SUM(match_win)*3+SUM(match_draw)*1) as score,
	RANK() OVER (PARTITION BY q.season,l.id ORDER BY (SUM(match_win)*3+SUM(match_draw)*1) DESC) AS Rank
	
FROM (SELECT season,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,home_team_api_id
	  UNION ALL
	  SELECT season,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,away_team_api_id) as q
	  INNER JOIN league l ON q.league_id = l.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
GROUP BY q.season,l.id,t.team_api_id
ORDER BY Rank, season ASC) as q_f WHERE Rank = 1) q
	INNER JOIN team_attributes t ON q.team_api_id = t.team_api_id) q1
WHERE (season_attribute = 0 AND (season_year_2 = date_year)) OR (season_attribute = 1 AND (season_year_1 = date_year))

/*Query 7.2*/
WITH leader_attributes as (SELECT season, league, team, buildUpPlaySpeedClass, buildUpPlayDribblingClass, buildUpPlayPassingClass, buildUpPlayPositioningClass, 
	chanceCreationPassingClass, chanceCreationCrossingClass, chanceCreationShootingClass, chanceCreationPositioningClass, 
	defencePressureClass, defenceAggressionClass, defenceTeamWidthClass, defenceDefenderLineClass, date

FROM(SELECT season, league, team, t.buildUpPlaySpeedClass, t.buildUpPlayDribblingClass, t.buildUpPlayPassingClass, 
	t.buildUpPlayPositioningClass, t.chanceCreationPassingClass, t.chanceCreationCrossingClass, t.chanceCreationShootingClass, 
	t.chanceCreationPositioningClass, t.defencePressureClass, t.defenceAggressionClass, t.defenceTeamWidthClass, 
	t.defenceDefenderLineClass, t.date, (CASE WHEN((EXTRACT('month' from t.date)::INT)>6) THEN 1 ELSE 0 END) as season_attribute,
	SUBSTRING ( season ,1 , 4 ) as season_year_1, SUBSTRING ( season ,6, 9 ) as season_year_2, EXTRACT('year' from t.date)::TEXT as date_year

FROM (SELECT * FROM(SELECT q.season,l.name as league,t.team_long_name as team, t.team_api_id,SUM(match_win) as macth_win_total,
	SUM(match_lose) as macth_lose_total,SUM(match_draw) as match_draw_total,
	(SUM(match_win)*3+SUM(match_draw)*1) as score,
	RANK() OVER (PARTITION BY q.season,l.id ORDER BY (SUM(match_win)*3+SUM(match_draw)*1) DESC) AS Rank
	
FROM (SELECT season,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,home_team_api_id
	  UNION ALL
	  SELECT season,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,away_team_api_id) as q
	  INNER JOIN league l ON q.league_id = l.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
GROUP BY q.season,l.id,t.team_api_id
ORDER BY Rank, season ASC) as q_f WHERE Rank = 1) q
	INNER JOIN team_attributes t ON q.team_api_id = t.team_api_id) q1
WHERE (season_attribute = 0 AND (season_year_2 = date_year)) OR (season_attribute = 1 AND (season_year_1 = date_year))) 

SELECT COUNT(*) as cant, buildUpPlaySpeedClass, buildUpPlayDribblingClass, buildUpPlayPassingClass, buildUpPlayPositioningClass, 
	chanceCreationPassingClass, chanceCreationCrossingClass, chanceCreationShootingClass, chanceCreationPositioningClass, 
	defencePressureClass, defenceAggressionClass, defenceTeamWidthClass, defenceDefenderLineClass 
FROM leader_attributes
GROUP BY buildUpPlaySpeedClass, buildUpPlayDribblingClass, buildUpPlayPassingClass, buildUpPlayPositioningClass, chanceCreationPassingClass, 
	chanceCreationCrossingClass, chanceCreationShootingClass, chanceCreationPositioningClass, defencePressureClass, defenceAggressionClass, 
	defenceTeamWidthClass, defenceDefenderLineClass
ORDER BY cant DESC;

/*Query 8*/
/* Segun apuestas*/
WITH match_ as (SELECT
	   id,country_id,league_id,season,stage,date,match_api_id,home_team_api_id,away_team_api_id,
			home_team_goal,away_team_goal,home_player_X1,home_player_X2,home_player_X3,
			home_player_X4,home_player_X5,home_player_X6,home_player_X7,home_player_X8,
			home_player_X9,home_player_X10,home_player_X11,away_player_X1,away_player_X2,
			away_player_X3,away_player_X4,away_player_X5,away_player_X6,away_player_X7,
			away_player_X8,away_player_X9,away_player_X10,away_player_X11,home_player_Y1,
			home_player_Y2,home_player_Y3,home_player_Y4,home_player_Y5,home_player_Y6,
			home_player_Y7,home_player_Y8,home_player_Y9,home_player_Y10,home_player_Y11,
			away_player_Y1,away_player_Y2,away_player_Y3,away_player_Y4,away_player_Y5,
			away_player_Y6,away_player_Y7,away_player_Y8,away_player_Y9,away_player_Y10,
			away_player_Y11,home_player_1,home_player_2,home_player_3,home_player_4,home_player_5,
			home_player_6,home_player_7,home_player_8,home_player_9,home_player_10,home_player_11,
			away_player_1,away_player_2,away_player_3,away_player_4,away_player_5,away_player_6,
			away_player_7,away_player_8,away_player_9,away_player_10,away_player_11,goal,shoton,
			shotoff,foulcommit,card,cross_,corner,possession,
	(B365H::FLOAT),
	(B365A::FLOAT),
	(BWH::FLOAT),
	(BWA::FLOAT),
	(IWH::FLOAT),
	(IWA::FLOAT),
	(LBH::FLOAT),
	(LBA::FLOAT),
	(PSH::FLOAT),
	(PSA::FLOAT),
	(WHH::FLOAT),
	(WHA::FLOAT),
	(SJH::FLOAT),
	(SJA::FLOAT),
	(VCH::FLOAT),
	(VCA::FLOAT),
	(GBH::FLOAT), 
	(GBA::FLOAT),
	(BSH::FLOAT),
	(BSA::FLOAT)
FROM (SELECT
	   id,country_id,league_id,season,stage,date,match_api_id,home_team_api_id,away_team_api_id,
				home_team_goal,away_team_goal,home_player_X1,home_player_X2,home_player_X3,
				home_player_X4,home_player_X5,home_player_X6,home_player_X7,home_player_X8,
				home_player_X9,home_player_X10,home_player_X11,away_player_X1,away_player_X2,
				away_player_X3,away_player_X4,away_player_X5,away_player_X6,away_player_X7,
				away_player_X8,away_player_X9,away_player_X10,away_player_X11,home_player_Y1,
				home_player_Y2,home_player_Y3,home_player_Y4,home_player_Y5,home_player_Y6,
				home_player_Y7,home_player_Y8,home_player_Y9,home_player_Y10,home_player_Y11,
				away_player_Y1,away_player_Y2,away_player_Y3,away_player_Y4,away_player_Y5,
				away_player_Y6,away_player_Y7,away_player_Y8,away_player_Y9,away_player_Y10,
				away_player_Y11,home_player_1,home_player_2,home_player_3,home_player_4,home_player_5,
				home_player_6,home_player_7,home_player_8,home_player_9,home_player_10,home_player_11,
				away_player_1,away_player_2,away_player_3,away_player_4,away_player_5,away_player_6,
				away_player_7,away_player_8,away_player_9,away_player_10,away_player_11,goal,shoton,
				shotoff,foulcommit,card,cross_,corner,possession,
	  (CASE
	  WHEN(B365H ='') THEN NULL
	  ELSE B365H
	  END) as B365H,
	  (CASE
	  WHEN(B365D ='') THEN NULL
	  ELSE B365D
	  END) as B365D,
	  (CASE
	  WHEN(B365A ='') THEN NULL
	  ELSE B365A
	  END) as B365A,
	  (CASE
	  WHEN(BWH ='') THEN NULL
	  ELSE BWH
	  END) as BWH,
	  (CASE
	  WHEN(BWD ='') THEN NULL
	  ELSE BWD
	  END) as BWD,
	  (CASE
	  WHEN(BWA ='') THEN NULL
	  ELSE BWA
	  END) as BWA,
	  (CASE
	  WHEN(IWH ='') THEN NULL
	  ELSE IWH
	  END) as IWH,
	  (CASE
	  WHEN(IWD ='') THEN NULL
	  ELSE IWD
	  END) as IWD,
	  (CASE
	  WHEN(IWA ='') THEN NULL
	  ELSE IWA
	  END) as IWA,
	  (CASE
	  WHEN(LBH ='') THEN NULL
	  ELSE LBH
	  END) as LBH,
	  (CASE
	  WHEN(LBD ='') THEN NULL
	  ELSE LBD
	  END) as LBD,
	  (CASE
	  WHEN(LBA ='') THEN NULL
	  ELSE LBA
	  END) as LBA,
	  (CASE
	  WHEN(PSH ='') THEN NULL
	  ELSE PSH
	  END) as PSH,
	  (CASE
	  WHEN(PSD ='') THEN NULL
	  ELSE PSD
	  END) as PSD,
	  (CASE
	  WHEN(PSA ='') THEN NULL
	  ELSE PSA
	  END) as PSA,
	  (CASE
	  WHEN(WHH ='') THEN NULL
	  ELSE WHH
	  END) as WHH,
	  (CASE
	  WHEN(WHD ='') THEN NULL
	  ELSE WHD
	  END) as WHD,
	  (CASE
	  WHEN(WHA ='') THEN NULL
	  ELSE WHA
	  END) as WHA,
	  (CASE
	  WHEN(SJH ='') THEN NULL
	  ELSE SJH
	  END) as SJH,
	  (CASE
	  WHEN(SJD ='') THEN NULL
	  ELSE SJD
	  END) as SJD,
	  (CASE
	  WHEN(SJA ='') THEN NULL
	  ELSE SJA
	  END) as SJA,
	  (CASE
	  WHEN(VCH ='') THEN NULL
	  ELSE VCH
	  END) as VCH,
	  (CASE
	  WHEN(VCD ='') THEN NULL
	  ELSE VCD
	  END) as VCD,
	  (CASE
	  WHEN(VCA ='') THEN NULL
	  ELSE VCA
	  END) as VCA,
	  (CASE
	  WHEN(GBH ='') THEN NULL
	  ELSE GBH
	  END) as GBH,
	  (CASE
	  WHEN(GBD ='') THEN NULL
	  ELSE GBD
	  END) as GBD,
	  (CASE
	  WHEN(GBA ='') THEN NULL
	  ELSE GBA
	  END) as GBA,
	  (CASE
	  WHEN(BSH ='') THEN NULL
	  ELSE BSH
	  END) as BSH,
	  (CASE
	  WHEN(BSD ='') THEN NULL
	  ELSE BSD
	  END) as BSD,
	  (CASE
	  WHEN(BSA ='') THEN NULL
	  ELSE BSA
	  END) as BSA
	  FROM match) as q)

SELECT country FROM
(SELECT * FROM
(SELECT c.name as country,
		RANK() OVER (PARTITION BY q.season,c.id ORDER BY (100/AVG(B365)+100/AVG(BW)+100/AVG(IW)+
														 100/AVG(LB)+100/AVG(WH)+100/AVG(VC))/6 DESC) 
														 AS Rank
FROM (SELECT
		season,
		country_id,
		home_team_api_id as team_api_id,
		AVG(B365H) as B365,
		AVG(BWH) as BW,
		AVG(IWH) as IW,
		AVG(LBH) as LB,
		AVG(PSH) as PS,
		AVG(WHH) as WH,
		AVG(SJH) as SJ,
		AVG(VCH) as VC,
		AVG(GBH) as GB,
		AVG(BSH) as BS
	FROM match_
	GROUP BY season,country_id,home_team_api_id
	HAVING AVG(B365H) IS NOT NULL OR AVG(BWH) IS NOT NULL OR AVG(IWH) IS NOT NULL OR
	AVG(LBH) IS NOT NULL OR AVG(PSH) IS NOT NULL OR AVG(WHH) IS NOT NULL OR AVG(SJH) IS NOT NULL
	OR AVG(VCH) IS NOT NULL OR AVG(GBH) IS NOT NULL OR AVG(BSH) IS NOT NULL
	UNION ALL
	SELECT
		season,
		country_id,
		away_team_api_id as team_api_id,
		AVG(B365A) as B365,
		AVG(BWA) as BW,
		AVG(IWA) as IW,
		AVG(LBA) as LB,
		AVG(PSA) as PS,
		AVG(WHA) as WH,
		AVG(SJA) as SJ,
		AVG(VCA) as VC,
		AVG(GBA) as GB,
		AVG(BSA) as BS
	FROM match_
	GROUP BY season,country_id,away_team_api_id
	HAVING AVG(B365A) IS NOT NULL OR AVG(BWA) IS NOT NULL OR AVG(IWA) IS NOT NULL OR
	AVG(LBA) IS NOT NULL OR AVG(PSA) IS NOT NULL OR AVG(WHA) IS NOT NULL OR AVG(SJA) IS NOT NULL
	OR AVG(VCA) IS NOT NULL OR AVG(GBA) IS NOT NULL OR AVG(BSA) IS NOT NULL) as q
	INNER JOIN country c ON q.country_id = c.id
	INNER JOIN team t ON q.team_api_id = t.team_api_id
GROUP BY q.season,c.id,t.team_api_id
ORDER BY Rank,season ASC) as q_f
WHERE Rank = 1) as r
GROUP BY country
ORDER BY COUNT(*) DESC LIMIT 3;

/* Segun estadisticas*/
SELECT country FROM
(SELECT * FROM
(SELECT q.season,c.name as country,t.team_long_name as team,SUM(goal_difference) as goal_difference_total,
RANK() OVER (PARTITION BY q.season,c.id ORDER BY SUM(goal_difference) DESC) AS Rank
FROM (SELECT season,SUM(home_team_goal::INT) as favor_goals, SUM(away_team_goal::INT) as against_goals,
	  (SUM(home_team_goal::INT) - SUM(away_team_goal::INT)) as goal_difference, country_id,
	  home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,country_id,home_team_api_id
	  UNION ALL
	  SELECT season,SUM(away_team_goal::INT) as favor_goals, SUM(home_team_goal::INT) as against_goals,
	  (SUM(away_team_goal::INT) - SUM(home_team_goal::INT)) as goal_difference, country_id,
	  away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,country_id,away_team_api_id) as q
	  INNER JOIN country c ON q.country_id = c.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
GROUP BY q.season,c.id,t.team_api_id
ORDER BY Rank, season ASC) as q_f
WHERE Rank = 1) as r
GROUP BY country
ORDER BY COUNT(*) DESC LIMIT 3;

/*Query Tablas de la liga*/
SELECT q.season,l.name as league,t.team_long_name as team,SUM(match_win) as match_win_total,
SUM(match_lose) as match_lose_total,SUM(match_draw) as match_draw_total,
(SUM(match_win)*3+SUM(match_draw)*1) as score,
RANK() OVER (PARTITION BY q.season,l.id ORDER BY (SUM(match_win)*3+SUM(match_draw)*1) DESC) AS Rank
FROM (SELECT season,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,home_team_api_id
	  UNION ALL
	  SELECT season,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,away_team_api_id) as q
	  INNER JOIN league l ON q.league_id = l.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
GROUP BY q.season,l.id,t.team_api_id
ORDER BY Rank, season ASC;

/*Etapa 3*/
/*Query 1*/
SELECT q.season,l.name as league,t.team_long_name as team,SUM(match_win) as match_win_total,
SUM(match_lose) as match_lose_total,SUM(match_draw) as match_draw_total,
RANK() OVER (PARTITION BY q.season,l.id ORDER BY (SUM(match_win)*3+SUM(match_draw)*1) DESC) AS Rank
FROM (SELECT season,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,home_team_api_id
	  UNION ALL
	  SELECT season,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,away_team_api_id) as q
	  INNER JOIN league l ON q.league_id = l.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
WHERE season = '2015/2016' OR season = '2014/2015' OR season = '2013/2014'
GROUP BY q.season,l.id,t.team_api_id
ORDER BY Rank, season ASC;

/*Query 2*/
SELECT q.season,l.name as league,t.team_long_name as team,
(SUM(match_win)*3+SUM(match_draw)*1) as score,
RANK() OVER (PARTITION BY q.season,l.id ORDER BY (SUM(match_win)*3+SUM(match_draw)*1) DESC) AS Rank
FROM (SELECT season,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,home_team_api_id
	  UNION ALL
	  SELECT season,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,away_team_api_id) as q
	  INNER JOIN league l ON q.league_id = l.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
WHERE season = '2015/2016' OR season = '2014/2015' OR season = '2013/2014'
GROUP BY q.season,l.id,t.team_api_id
ORDER BY Rank, season ASC;

/*Query 3*/
WITH match_ as (SELECT q.season,l.name as league,t.team_long_name as team,
(SUM(match_win)*3+SUM(match_draw)*1) as score
FROM (SELECT season,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((home_team_goal::INT) - (away_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,home_team_api_id
	  UNION ALL
	  SELECT season,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))>0) THEN 1 ELSE 0 END) as match_win,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))<0) THEN 1 ELSE 0 END) as match_lose,
	  SUM(CASE WHEN(((away_team_goal::INT) - (home_team_goal::INT))=0) THEN 1 ELSE 0 END) as match_draw,
	  league_id,
	  away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,away_team_api_id) as q
	  INNER JOIN league l ON q.league_id = l.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
WHERE season = '2015/2016' OR season = '2014/2015' OR season = '2013/2014'
GROUP BY q.season,l.id,t.team_api_id
ORDER BY season ASC)

SELECT team,AVG(improvement)::FLOAT as improvement_avg,
RANK() OVER (ORDER BY AVG(improvement) DESC) as Rank
FROM (SELECT m1.league,m1.team,
	(CASE WHEN((m2.score-m1.score)>0) THEN (m2.score-m1.score) ELSE 0 END) as improvement
	FROM match_ m1
		INNER JOIN match_ m2 ON m1.team = m2.team AND m1.season<m2.season
	WHERE (m1.season != '2013/2014' OR m2.season != '2015/2016')) as q
GROUP BY team
ORDER BY Rank;

/*Query 4*/
SELECT q.season,l.name as league,t.team_long_name as team,SUM(goal_difference) as goal_difference_total,
RANK() OVER (PARTITION BY q.season,l.id ORDER BY SUM(goal_difference) DESC) AS Rank
FROM (SELECT season,SUM(home_team_goal::INT) as favor_goals, SUM(away_team_goal::INT) as against_goals,
	  (SUM(home_team_goal::INT) - SUM(away_team_goal::INT)) as goal_difference, league_id,
	  home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,home_team_api_id
	  UNION ALL
	  SELECT season,SUM(away_team_goal::INT) as favor_goals, SUM(home_team_goal::INT) as against_goals,
	  (SUM(away_team_goal::INT) - SUM(home_team_goal::INT)) as goal_difference, league_id,
	  away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,away_team_api_id) as q
	  INNER JOIN league l ON q.league_id = l.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
WHERE season = '2015/2016' OR season = '2014/2015' OR season = '2013/2014'
GROUP BY q.season,l.id,t.team_api_id
ORDER BY Rank, season ASC

/*Query 5*/
WITH match_ as (SELECT q.season,l.name as league,t.team_long_name as team,
				SUM(goal_difference) as goal_difference_total
FROM (SELECT season,SUM(home_team_goal::INT) as favor_goals, SUM(away_team_goal::INT) as against_goals,
	  (SUM(home_team_goal::INT) - SUM(away_team_goal::INT)) as goal_difference, league_id,
	  home_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,home_team_api_id
	  UNION ALL
	  SELECT season,SUM(away_team_goal::INT) as favor_goals, SUM(home_team_goal::INT) as against_goals,
	  (SUM(away_team_goal::INT) - SUM(home_team_goal::INT)) as goal_difference, league_id,
	  away_team_api_id as team_api_id
	  FROM match m
	  GROUP BY season,league_id,away_team_api_id) as q
	  INNER JOIN league l ON q.league_id = l.id
	  INNER JOIN team t ON q.team_api_id = t.team_api_id
WHERE season = '2015/2016' OR season = '2014/2015' OR season = '2013/2014'
GROUP BY q.season,l.id,t.team_api_id
ORDER BY season ASC)

SELECT team,AVG(improvement)::FLOAT as improvement_avg,
RANK() OVER (ORDER BY AVG(improvement) DESC) as Rank
FROM (SELECT m1.league,m1.team,
	(CASE
	 WHEN((m2.goal_difference_total-m1.goal_difference_total)>0)
	 THEN (m2.goal_difference_total-m1.goal_difference_total) ELSE 0 END) as improvement
	FROM match_ m1
		INNER JOIN match_ m2 ON m1.team = m2.team AND m1.season<m2.season
	WHERE (m1.season != '2013/2014' OR m2.season != '2015/2016')) as q
GROUP BY team
ORDER BY Rank;