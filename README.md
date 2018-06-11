# NBA_Win_Probability-
In-game logistic regression win probability model for NBA matchups 

Like in almost any sport, the NBA is a perfect template for betting and win probability models.   Websites such as FiveThirtyEight have already built relatively sophisticated win probability models that provide good accuracy for predicting matchups across the league.    

With this motivation, we built an in-game win probability logistic regression model from over 500,000 play-by-play observations from the 2017-2018 NBA season. Our first attempt of the model used the time remaining in the game (in seconds) and score differential as predictors of whether the home team wins or not. 

Estimate	Std.	Error	z	P-value
(Intercept)	1.85E-01	1.35E-02	13.739	<0.0000000000000002
time	-6.96E-05	8.56E-06	-8.122	<0.000000000000000459
SCOREMARGIN	2.03E-01	1.13E-03	180.21	<2.00E-16

Figure 1: Coefficients for the win probability logistic regression model 

As the model results show, both the time remaining and score margin are significant in terms of predicting the home team’s outcome (probability of winning or losing throughout the game). 

Obviously, having superstars like LeBron James or Kevin Durant on the court improves the Cavaliers and Warrior’s win probability at any given moment in the game. We would like to account for these types of player adjustments in a future win probability model. In the end, relying on the score differential and time remaining in the game is somewhat limited in terms of estimating win probability. 

Read Here: 
