## Introduction
The analysis began by collecting the opening and closing odds of more than 26,000 tennis matches that occurred between 2009 and mid-September 2015. 

The odds were downloaded for Association of Tennis Professionals (ATP) and Grand Slam matches from seven large, independent bookmakers.
This is the world of sports betting, where a fascinating game plays out behind the scenes—within the data. Picture a treasure chest filled with information from 129,271 tennis matches bets, each match telling its unique story through numbers. 

Our adventure begins by using Excel and cleaning data before importing to MySQL. Afterwards, with the help of SQL language we uncover the secrets and exciting tales hidden in the intricate maze of tennis betting data.

## Project Overview
The project involves querying, analyzing and visualizing a dataset containing tennis betting information.

## Project Objective
The objective of this project is to analyze anonymous data and find patterns or trends.

## Descriptive Analysis
Total Matches and Cancellations: There are 129,271 tennis matches recorded. Only 1.6% (2151 matches) were cancelled or marked as walkovers. Only 2 matches with odds changes exceeding 10, indicating minimal fluctuations in most cases. 

Odds Analysis: Analysis of odds movements revealed fluctuations between opening and closing odds for both winners and losers.
These changes can reach extremes, showcasing significant variations. Fluctuations: Investigated major fluctuations in odds: Identified top fluctuations for winners (absolute values): Maximum increase: +23 Maximum decrease: -20 For losers, variations were more substantial. 

Correlation between Odds Movement and Match Outcomes: A correlation coefficient suggests that there's a strong connection between changes in odds before a match and the final outcome. 

Variations in Probabilities: For favorites, there's a 41% chance of their odds becoming more assertive, indicating a shift in perception. Conversely, underdogs often witness a decrease in their winning probability by 60%. 

Yearly Trends in Odds and Probabilities: Over the years, there's a consistent trend showing increased competitiveness, leading to higher odds and implied probabilities for winners and losers alike. 

Bookmakers' Odds: Bookmakers sometimes offer varied odds for the same match, providing bettors with choices that can significantly impact potential winnings. In instances of varied odds, the range was notable: e.g., odds ranged from 1.83 to 2.06 for a specific match. 

Probability Fluctuations: Probability changes generally occur within the range of 10 to 20%, with only 6% of changes exceeding the 20% mark.

## Inferential Analysis
In examining over 129,000 tennis matches, we found that only a small fraction, about 1.6%, were canceled or had walkovers.
Most matches proceeded as scheduled. When looking at the odds for these matches, we noticed fluctuations in the betting odds before matches, with some extreme changes observed, though these were rare. Interestingly, these odds movements were strongly tied to the actual match outcomes, indicating a clear link between pre-match odds and the final results.

Our analysis showed a noticeable shift in perceptions regarding favorites and underdogs. Favorites tended to see their odds improve by around 41%, while underdogs faced a significant 60% decrease in their winning probability. Over the years, there has been a trend towards increased competitiveness in tennis matches, leading to higher odds and implied probabilities for both winners and losers.

One interesting finding was the variation in odds offered by different bookmakers for the same match. This variability could significantly impact potential winnings. Despite fluctuations in odds, most changes in probabilities stayed within a 10 to 20% range, with only a small fraction exceeding this mark, suggesting a relatively stable betting landscape in terms of probability shifts.

Overall, our project aimed to uncover patterns and trends within this anonymized tennis match data.The analysis revealed the intricate relationship between odds, probabilities, and actual match outcomes, providing insights into the dynamic nature of betting in tennis.
