
--Adding the home teams name column--
ALTER TABLE prem_statsSheet12 
add column team_name

update prem_statsSheet12 SET team_name = 'Arsenal' Where stadium = 'Emirates Stadium';
update prem_statsSheet12 SET team_name = 'Aston Villa' Where stadium = 'Villa Park';
update prem_statsSheet12 SET team_name = 'Brentford' Where stadium = 'Gtech Community Stadium';
update prem_statsSheet12 SET team_name = 'Chelsea' Where stadium = 'Stamford Bridge';
update prem_statsSheet12 SET team_name = 'Wolverhampton Wanderers F.C.' Where stadium = 'Molineux';
update prem_statsSheet12 SET team_name = 'Everton' Where stadium = 'Goodison Park';
update prem_statsSheet12 SET team_name = 'Manchester City' Where stadium = 'Etihad Stadium';
update prem_statsSheet12 SET team_name = 'Leeds United' Where stadium = 'Elland Road';
update prem_statsSheet12 SET team_name = 'Liverpool' Where stadium = 'Anfield';
update prem_statsSheet12 SET team_name = 'Tottenham' Where stadium = 'Tottenham Hotspur Stadium';
update prem_statsSheet12 SET team_name = 'Fulham' Where stadium = 'Craven Cottage';
update prem_statsSheet12 SET team_name = 'Brighton & Hove Albion' Where stadium = 'Amex Stadium';
update prem_statsSheet12 SET team_name = 'Southampton' Where stadium = "St. Mary's Stadium";
update prem_statsSheet12 SET team_name = 'Nottingham Forest' Where stadium = 'The City Ground';
update prem_statsSheet12 SET team_name = 'Leicester City' Where stadium = 'The King Power Stadium';
update prem_statsSheet12 SET team_name = 'Newcastle United' Where stadium = "St James' Park, Newcastle";
update prem_statsSheet12 SET team_name = 'West Ham United' Where stadium = 'London Stadium';
update prem_statsSheet12 SET team_name = 'AFC Bournemouth' Where stadium = 'Vitality Stadium';
update prem_statsSheet12 SET team_name = 'Manchester United' Where stadium = 'Old Trafford';
update prem_statsSheet12 SET team_name = 'Crystal Palace' Where stadium = 'Selhurst Park';

select away_team
from prem_statsSheet12

-- which team won the most home games -- 

SELECT team_name, 
case 
     when goals_home > away_goals then 'Home Team Won'
     when goals_home = away_goals then 'Draw'
     else 'Home Team Lost'
end as Result_of_match,
from prem_statsSheet12
group by team_name;

-- calculate who got the most points at home--
SELECT team_name, 
sum(case 
     when goals_home > away_goals then 3
     when goals_home = away_goals then 1
     else 0
end ) as points

from prem_statsSheet12
group by team_name 
order by points desc

-- see what stadium has most goals--
select stadium, sum(total_goals)

from prem_statsSheet12

group by stadium
order by sum(total_goals) DESC

-- see what stadium the most fouls are commited in--
select stadium , sum(total_fouls)

from prem_statsSheet12

group by stadium
order by sum(total_fouls) DESC

-- see what home team commits the most fouls--
select stadium , sum(home_fouls)

from prem_statsSheet12

group by stadium
order by sum(home_fouls) DESC
limit 7

select stadium , ROUND(avg(home_fouls),2)

from prem_statsSheet12

group by stadium
order by avg(home_fouls) DESC
limit 7

--Find which home team dominated possesion and which home team was dominated at home--
select stadium,ROUND( avg(home_possessions), 2),
CASE
     when avg(home_possessions) < 45 THEN 'Less possesion'
     when avg(home_possessions) BETWEEN 46 AND 54 THEN 'no domination' 
     else 'Dominated possesion'
END
FROM prem_statsSheet12

group by stadium
order by avg(home_possessions) DESC
LIMIT 7

--see if there is a correlation with the amoiunt of possession a team has and the amount of fouls they commit--

select stadium,ROUND( avg(home_possessions), 2) as possesion, ROUND(avg(total_fouls) , 2) as fouls ,
CASE
     when avg(home_possessions) < 45 THEN 'Less possesion'
     when avg(home_possessions) BETWEEN 46 AND 54 THEN 'no domination' 
     else 'Dominated possesion'
END
FROM prem_statsSheet12

group by stadium
order by avg(home_possessions) DESC

-- see if there is a correlation between shots and goals for home team--
select stadium, round(avg(home_shots),2), round(avg(goals_home),2)

from prem_statsSheet12

group by stadium
order by avg(home_shots) DESC

--find the average amount fos shots taken per goal for home team--

select stadium, round(avg(home_shots),2), round(avg(goals_home),2)
, avg(home_shots)/avg(goals_home) AS shot_to_goal_ratio
       
from prem_statsSheet12

group by stadium
order by round(shot_to_goal_ratio,2)
LIMIT 7


-- find the average amount of shots it took away teams to score at stadiums--

select stadium, round(avg(away_shots),2), round(avg(away_goals),2)
, avg(away_shots)/avg(away_goals) AS shot_to_goal_ratio
       
from prem_statsSheet12

group by stadium
order by round(shot_to_goal_ratio,2) DESC
LIMIT 7










 
