import pandas as pd 
import numpy as np 
from sklearn import preprocessing
import sklearn 
from sklearn.feature_selection import RFE
from sklearn.linear_model import LogisticRegression

#6/17/18 
#adding player lineups into the win probability model (using logistic regression)
nba_pbp=pd.read_csv("orange_pollo.csv")

nba_pbp1=nba_pbp 
nba_pbp1=nba_pbp1.fillna(nba_pbp1.mean())
nba_pbp1.info() 

nba_pbp1['home_win'].unique() #0,1 
nba_pbp1['home_win'].value_counts() 
nba_pbp1['SHOT_MADE'].value_counts() 

nba_pbp1.info() 
nba_pbp1['HOME_PLAYER_ID_5']=nba_pbp1['HOME_PLAYER_ID_5'].astype(object)

#convert numeric to categorical 
nba_pbp1['HOME_PLAYER_ID_1']=pd.Categorical(nba_pbp1['HOME_PLAYER_ID_1'])
nba_pbp1['HOME_PLAYER_ID_2']=pd.Categorical(nba_pbp1['HOME_PLAYER_ID_2'])
nba_pbp1['HOME_PLAYER_ID_3']=pd.Categorical(nba_pbp1['HOME_PLAYER_ID_3'])
nba_pbp1['HOME_PLAYER_ID_4']=pd.Categorical(nba_pbp1['HOME_PLAYER_ID_4'])
nba_pbp1['HOME_PLAYER_ID_5']=pd.Categorical(nba_pbp1['HOME_PLAYER_ID_5'])

nba_pbp1['AWAY_PLAYER_ID_1']=pd.Categorical(nba_pbp1['AWAY_PLAYER_ID_1'])
nba_pbp1['AWAY_PLAYER_ID_2']=pd.Categorical(nba_pbp1['AWAY_PLAYER_ID_2'])
nba_pbp1['AWAY_PLAYER_ID_3']=pd.Categorical(nba_pbp1['AWAY_PLAYER_ID_3'])
nba_pbp1['AWAY_PLAYER_ID_4']=pd.Categorical(nba_pbp1['AWAY_PLAYER_ID_4'])
nba_pbp1['AWAY_PLAYER_ID_5']=pd.Categorical(nba_pbp1['AWAY_PLAYER_ID_5'])

nba_pbp1['SHOT_PLAYER_ID']=pd.Categorical(nba_pbp1['SHOT_PLAYER_ID'])
nba_pbp1['SHOT_MADE  ']=pd.Categorical(nba_pbp1['SHOT_MADE'])

X=nba_pbp1[['SCOREMARGIN','time','HOME_PLAYER_ID_1','HOME_PLAYER_ID_2',
'HOME_PLAYER_ID_3','HOME_PLAYER_ID_4','HOME_PLAYER_ID_5',
'AWAY_PLAYER_ID_1','AWAY_PLAYER_ID_2','AWAY_PLAYER_ID_3',
'AWAY_PLAYER_ID_4','AWAY_PLAYER_ID_5','SHOT_MADE','SHOT_PLAYER_ID']]
y=nba_pbp1[['home_win']]

lr=LogisticRegression() 
fit=lr.fit(X,y)
fit.get_params
predict_lr=fit.predict_proba(X)

