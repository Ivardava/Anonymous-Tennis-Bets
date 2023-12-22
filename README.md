## Tennis Bets Analysis
**Introduction**
This project contains an analysis of tennis betting data, exploring trends, correlations, and insights derived from odds movements and match outcomes. The analysis is performed using MySQL queries on the provided dataset.

**Project Overview**
The project involves querying and analyzing a dataset containing tennis betting information. Key aspects covered in the analysis include:

## General statistics about matches
Odds analysis: examining odds fluctuations and correlations
Variations in implied probabilities and their impact
Yearly trends in odds and implied probabilities
Analysis of different bookmakers' odds discrepancies
Analysis of match cancellations and walkovers
SQL Analysis
The SQL queries within this project perform various analyses, including:

## Creation of a schema and table for the dataset
**Importing data into the table**
General analysis, including total matches, cancelled matches, average odds, and more
Odds analysis: exploring fluctuations, correlations, and variations
Yearly trends in odds and implied probabilities
Detailed examination of specific matches with different odds
Analysis of match cancellations and probabilities' percentage changes

## Summaries
**General Analysis**

Total Matches: Analyzed a dataset containing 129,271 matches.

Cancelled Matches: Identified 2151 matches as cancelled, constituting 1.6% of total matches.

Odds Movements: Observed significant fluctuations in opening and closing odds for winners and losers.

**Average Odds:**
Winners: The average opening odds for winners were 3.25 and closing odds were 3.10.

Losers: The average opening odds for losers were 5.72 and closing odds were 5.60.

**Odds Analysis**
Fluctuations: Investigated major fluctuations in odds:
Identified top fluctuations for winners (absolute values):
Maximum increase: +23
Maximum decrease: -20
For losers, variations were more substantial.

Correlation Analysis: Explored correlations between odds movement and match outcomes. The correlation coefficient indicated a strong association between odds movement and match outcomes.
Probabilities Variations:

Winners: Probability shifted upwards in 41% of cases between opening and closing odds.

Losers: Probability shifted downwards in 60% of cases between opening and closing odds.

**Yearly Trends**

**Trend Analysis:**
Noticed a positive correlation between odds yearly:
Average opening odds increased from 3.5 in 2016 to 4.8 in 2021 for winners.
Average opening odds increased from 6.2 in 2016 to 7.5 in 2021 for losers.
Similar trends were observed in implied probabilities.

**Bookmakers' Odds Discrepancies**

**Different Odds:**
Observed significant discrepancies in odds offered by different bookmakers for the same match.
In instances of varied odds, the range was notable: e.g., odds ranged from 1.83 to 2.06 for a specific match.

## Match Cancellations
**Cancelled Matches:**
Examined cancelled matches and their impact on odds.
Noted only two matches with odds changes exceeding 10, indicating minimal fluctuations in most cases.
