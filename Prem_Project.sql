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










 
