# create schema
CREATE SCHEMA tennis_bets;


# use of schema
USE tennis_bets;


# drop table if it exists before creating
DROP TABLE IF EXISTS bets;


# create table with respective dtypes
CREATE TABLE bets(
match_book_uid VARCHAR(100) NOT NULL,
odds_winner_open FLOAT,
loser_open FLOAT,
odds_winner_close FLOAT,
odds_loser_close FLOAT,
year INT NOT NULL,
implied_prob_winner_open FLOAT,
implied_prob_loser_open FLOAT,
implied_prob_winner_close FLOAT,
implied_prob_loser_close FLOAT,
moved_towards_winner ENUM('FALSE','TRUE'),
book VARCHAR(20),
loser VARCHAR(100) NOT NULL,
winner VARCHAR(100) NOT NULL,
is_cancelled_or_walkover ENUM('FALSE','TRUE'),
match_uid VARCHAR(100) NOT NULL
);


# check if table is created
SELECT * FROM bets;


# imported data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Anonymous bets/anonymous_betting_data.csv'
INTO TABLE bets
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


# TIME TO START ANALYSIS
SELECT * FROM bets;

# GENERAL ANALYSIS

# TOTAL MATCHES
SELECT
    COUNT(*) as number_of_matches_total
FROM
	bets;
    
# TOTAL CANCELLED MATCHES
SELECT
    COUNT(*) as number_of_matches_total
FROM
	bets
WHERE is_cancelled_or_walkover = 'TRUE';

# TOTAL INCREASE WITH WINNERS FAVOR
SELECT
    COUNT(*) as total_winner_increases
FROM
	bets
WHERE odds_winner_open < odds_winner_close;

# TOTAL DECREASE WITH WINNERS ODDS
SELECT
    COUNT(*) as total_winner_increases
FROM
	bets
WHERE odds_winner_open > odds_winner_close;

# AVERAGE WINNER COEFFIECIENT
SELECT
	ROUND(AVG(odds_winner_open),2) as Average_winner
FROM
	bets;


# AVERAGE LOSER COEFFIECIENT
SELECT
	ROUND(AVG(odds_loser_open),2) as Average_loser
FROM
	bets;
#Odds Analysis:

# 1. How do the opening and closing odds for winners and losers differ across matches?
# 2. Is there a correlation between odds movement (from open to close) and match outcomes?

# FIND MAXIMUM FLUCTUATION IN OPENING AND CLOSING ODDS	
# WINNERS PERSPECTIVE
WITH CTE AS(
SELECT
	LEFT(match_book_uid,5) as match_uid,
	odds_winner_open,
    odds_winner_close,
    ROUND(ABS(odds_winner_open - odds_winner_close),2) as difference,
    CONCAT(
           CASE
               WHEN odds_winner_close > odds_winner_open THEN '+ '
               WHEN odds_winner_close < odds_winner_open THEN '- '
               ELSE ''
           END,
           ROUND(ABS(odds_winner_open - odds_winner_close),2)
       ) AS difference_with_sign
FROM
	bets
ORDER BY ABS(difference) DESC
LIMIT 10)
SELECT 
	*,
	LPAD(' ', difference, '*') as chart
FROM
	CTE;
# LITTLE SUMMARY: As we can see in some matches during these years there were high fluctuations between opening and closing odds
# The highest 2 fluctuations are -23 and + 20. Which means that there were so many heavy bets on this matches
# Out of this TOP 10 we see that fluctations direction is 50/50, half went up and half went down.


# LOSERS PERSPECTIVE
WITH CTE AS(
SELECT
	LEFT(match_book_uid,5) as match_uid,
	odds_loser_open,
    odds_loser_close,
    ROUND(ABS(odds_loser_open - odds_loser_close),2) as difference,
    CONCAT(
           CASE
               WHEN odds_loser_close > odds_loser_open THEN '+ '
               WHEN odds_loser_close < odds_loser_open THEN '- '
               ELSE ''
           END,
           ROUND(ABS(odds_loser_open - odds_loser_close),2)
       ) AS difference_with_sign
FROM
	bets
ORDER BY ABS(difference) DESC
LIMIT 10)
SELECT 
	*,
	LPAD(' ', difference/10, '*') as chart
FROM
	CTE;
# LITTLE SUMMARY: Compared to winners perspective, here we see much higher fluctuations
# **also note that the fluctuation in losers side can be caused by potential injury of the player
# although as we can see the odds really vary a lot


# 2. Is there a correlation between odds movement (from open to close) and match outcomes?
SELECT 
    (
        COUNT(*) * SUM(odds_winner_open * odds_winner_close) - SUM(odds_winner_open) * SUM(odds_winner_close)
    ) / (
        SQRT((COUNT(*) * SUM(odds_winner_open * odds_winner_open)) - (SUM(odds_winner_open) * SUM(odds_winner_open))) * 
        SQRT((COUNT(*) * SUM(odds_winner_close * odds_winner_close)) - (SUM(odds_winner_close) * SUM(odds_winner_close)))
    ) AS correlation_coefficient
FROM 
    bets;
# LITTLE SUMMARY: in 95% of scenario we see that changing in one dimension, we should expect immediate change to second odd


# VARIATIONS
# 1. HOW PROBABILITIES VARY? 
# 2. DOES IT HAVE INCREASE OR DECREASE
# ** FROM WINNERS PERSPECTIVE

SELECT
	COUNT(CASE WHEN odds_winner_close > odds_winner_open THEN match_uid ELSE NULL END) AS shifted_up,
    COUNT(CASE WHEN odds_winner_close < odds_winner_open THEN match_uid ELSE NULL END) AS shifted_down,
    ROUND(COUNT(CASE WHEN odds_winner_close > odds_winner_open THEN match_uid ELSE NULL END)
    /
     (COUNT(CASE WHEN odds_winner_close < odds_winner_open THEN match_uid ELSE NULL END)
     +
     COUNT(CASE WHEN odds_winner_close > odds_winner_open THEN match_uid ELSE NULL END))
     ,2) AS up_prct
FROM
	bets;
# LITTLE SUMMARY: when a player is set to be a favourite with certain odd, it is 41% of chances that their favorite status
# will get more assertive. in 59% of cases favorite player odds are increaseing
# meaning they are not considered as the same favorites as it was before the match

# VARIATIONS
# 1. HOW PROBABILITIES VARY? 
# 2. DOES IT HAVE INCREASE OR DECREASE
# ** FROM LOSERS PERSPECTIVE

SELECT
	COUNT(CASE WHEN odds_loser_close > odds_loser_open THEN match_uid ELSE NULL END) AS shifted_up,
    COUNT(CASE WHEN odds_loser_close < odds_loser_open THEN match_uid ELSE NULL END) AS shifted_down,
    ROUND(COUNT(CASE WHEN odds_loser_close > odds_loser_open THEN match_uid ELSE NULL END)
    /
     (COUNT(CASE WHEN odds_loser_close < odds_loser_open THEN match_uid ELSE NULL END)
     +
     COUNT(CASE WHEN odds_loser_close > odds_loser_open THEN match_uid ELSE NULL END))
     ,2) AS up_prct
FROM
	bets;
# LITTLE SUMMARY: Talking from losers perspective, here situations is opposite.
# Before the match if player is 'underdog' it means that there is 60% of the chance that their winning probabilty will go down


# YEARLY TRENDS with Odds
# How have betting odds or implied probabilities changed over the years? Any noticeable trends or patterns?

SELECT
	year,
	ROUND(AVG(odds_winner_open),2) as odd_winner,
    ROUND(AVG(odds_loser_open),2) as odd_loser
FROM
	bets
GROUP BY YEAR
ORDER BY YEAR ASC;
# LITTLE SUMMARY: we can see a positive correlation between odds yearly
# we can roughly say that the competition are getting tough and players who are known to be a middle class players
# they are going to be eaten by the real sharks


# YEARLY TRENDS with Probabilities

SELECT
	year,
	ROUND(AVG(implied_prob_winner_open),2) as odd_winner,
    ROUND(AVG(implied_prob_winner_close),2) as odd_loser
FROM
	bets
GROUP BY YEAR
ORDER BY YEAR ASC;
# LITTLE SUMMARY: we see the same tendancy as we saw with odds, which is not surprising


# LETS GET ONE OR TWO MATCHES WERE BOOKMAKERS SET DIFFERENT ODDS
SELECT
	LEFT(match_uid,10) as match_id,
    count(match_book_uid) as '# of bookmaker odds'
FROM
	bets
GROUP BY 1
ORDER BY 2 desc;

# Do different bookmakers offer significantly different odds or implied probabilities?
# MATCH ID starting with 66570....
SELECT
	*
FROM
	bets
WHERE match_uid = '66570ac91907b79e6cda3c69aaea47812aee60020a3fe8e159d9453619a12610'
ORDER BY odds_winner_open ASC;
# LITTLE SUMMARY: In some occasions bookmakers really set different odds initially
# here we can see that betters could have find odds from 1.83 to 2.06

# Do different bookmakers offer significantly different odds or implied probabilities?
# MATCH ID starting with 3071....
SELECT
	*
FROM
	bets
WHERE match_uid = '3071b3f77034575a8801c5f424ed0c1e757822c3bf13c60ba57fe8476a0c4a0a'
ORDER BY odds_winner_open ASC;
# the same results. betters could have find odds from 1.33 to 1.43
# it means that If I was a better and I had to place a bet on someone whos odd were from 1.33 and 1.43
# I would rather chosen the one which is higher, because if i corretly guess the winner I want to get more


# CANCELLATIONS AND WALKOVERS

SELECT
	is_cancelled_or_walkover,
    COUNT(*) as number_of_canc_walkover
FROM
	bets
GROUP BY 1;
# LITTLE SUMMARY: OUT OF 129,271 matches only 2151 matches cancelled which is 1.6 %

# OVERVIEW of Matches wich got cancelled or walkover
SELECT
	LEFT(match_uid,10) as match_id,
	odds_winner_open,
    odds_winner_close,
	 ROUND(ABS(odds_winner_open - odds_winner_close),2) as difference,
    CONCAT(
           CASE
               WHEN odds_winner_close > odds_winner_open THEN '+ '
               WHEN odds_winner_close < odds_winner_open THEN '- '
               ELSE ''
           END,
           ROUND(ABS(odds_winner_open - odds_winner_close),2)
       ) AS difference_with_sign
FROM
	bets
WHERE is_cancelled_or_walkover = 'TRUE'
ORDER BY difference DESC;
# LITTLE SUMMARY: out of 2151 matches only two matches were when opening and closing odds changed with more than 10 coefficient
# also we see that only these two matches were when coefficient decreased, in all other cases it increased


# OVERVIEW OF THE MATCHES WHEN PROBABILITY IS CHANGED WITH MORE THAN 20-30%
WITH CTE AS(
SELECT
	LEFT(match_uid,10) as match_id,
	implied_prob_winner_open,
    implied_prob_winner_close,
    ROUND(ABS(implied_prob_winner_open - implied_prob_winner_close)* 100,0)as prob_difference
FROM
	bets)
SELECT
	*
FROM
	CTE
WHERE prob_difference BETWEEN 20 and 30
ORDER BY prob_difference DESC;



# PROBABILITY CHANGE OCCURANCIES FROM 10 to 50
WITH CTEB AS(
WITH CTE AS(
SELECT
	implied_prob_winner_open,
    implied_prob_winner_close,
    ROUND(ABS(implied_prob_winner_open - implied_prob_winner_close)* 100,0)as prob_difference
FROM
	bets)
SELECT
	*
FROM
	CTE
WHERE prob_difference BETWEEN 10 and 50
ORDER BY prob_difference DESC)
SELECT
	prob_difference,
    COUNT(*) as number_of_occurancies,
    LPAD('',COUNT(*)/50, '*') as bar
FROM
	CTEB
GROUP BY prob_difference
ORDER BY 2 DESC;
# LITTLE SUMMARY: Between 10 and 20, where probabilty change happens


# NUMBER OF OCCURANCIES IN PROBABILTY PERCENTAGE CHANGE (FROM 1 to 50)
WITH CTEB AS(
WITH CTE AS(
SELECT
	LEFT(match_uid,10) as match_id,
	implied_prob_winner_open,
    implied_prob_winner_close,
    ROUND(ABS(implied_prob_winner_open - implied_prob_winner_close)* 100,0)as prob_difference
FROM
	bets)
SELECT
	*
FROM
	CTE
WHERE prob_difference BETWEEN 10 and 50
ORDER BY prob_difference DESC)
SELECT
	COUNT(CASE WHEN prob_difference BETWEEN 10 AND 50 THEN match_id ELSE NULL END) as total,
	COUNT(CASE WHEN prob_difference BETWEEN 10 AND 20 THEN match_id ELSE NULL END) as '10_to_20',
    COUNT(CASE WHEN prob_difference >= 21 THEN match_id ELSE NULL END) as '20+',
    ROUND(COUNT(CASE WHEN prob_difference >= 21 THEN match_id ELSE NULL END) 
    /
    (COUNT(CASE WHEN prob_difference >= 21 THEN match_id ELSE NULL END)
    +
    COUNT(CASE WHEN prob_difference BETWEEN 10 AND 20 THEN match_id ELSE NULL END)),2) as '20+ prct'
FROM
	CTEB;
# LITTLE SUMMARY: only 6% times the probabilty is changed with more than 20%. in all other 94% cases percentage change is between 10 to 20