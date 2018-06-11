#6/7/18 nba win porbability model
nba_pbp=read.csv("2017-18_pbp.csv")

#change variable types 
nba_pbp$SCOREMARGIN=as.numeric(as.character(nba_pbp$SCOREMARGIN))
nba_pbp$PERIOD=as.factor(nba_pbp$PERIOD)
nba_pbp$PLAYER1_ID=as.factor(nba_pbp$PLAYER1_ID)
nba_pbp$EVENTMSGTYPE=as.factor(nba_pbp$EVENTMSGTYPE)

library(lubridate) # for converting ms to seconds
library(dplyr)
library(plyr)
library(ggplot2)

#time remaining in the game 
nba_pbp$time_rem=period_to_seconds(ms(nba_pbp$PCTIMESTRING))
nba_pbp$time=720-nba_pbp$time_rem

#subset quarters 2,3,and 4
q1=subset(nba_pbp,nba_pbp$PERIOD==1)

q2=subset(nba_pbp,nba_pbp$PERIOD==2)
q2$time=q2$time_rem+720

q3=subset(nba_pbp,nba_pbp$PERIOD==3)
q3$time=q3$time_rem+1440

q4=subset(nba_pbp,nba_pbp$PERIOD==4)
q4$time=q4$time_rem+2160

#combine the adjusted time dataframe 
final_pbp=rbind(q1,q2,q3,q4)
final_pbp$home_win="NA"
final_pbp$GAME_ID=as.factor(final_pbp$GAME_ID)

#end of regulation (assign 1 for home win, 0 for home loss)
nba_end=subset(final_pbp,time==2880)
nba_end$home_win=ifelse(nba_end$SCOREMARGIN>0,1,0)
nba_end$GAME_ID=as.factor(nba_end$GAME_ID)

finalsX=rbind(final_pbp,nba_end)
finalsX$home_win=as.numeric(finalsX$home_win)

#road wins 
road_wins=subset(finalsX,home_win==0)
dim(road_wins)
head(road_wins)

common=intersect(road_wins$GAME_ID,finalsX$GAME_ID)
common1=as.data.frame(common)

road_wins_actual=finalsX %>%
  filter(finalsX$GAME_ID %in% common1$common)

#2. home wins
home_wins=subset(finalsX,home_win==1)
dim(home_wins)

common2=intersect(home_wins$GAME_ID,finalsX$GAME_ID)
common3=as.data.frame(common2)

home_wins_actual=finalsX %>%
  filter(finalsX$GAME_ID %in% common3$common2)

road_wins_actual$home_win=0
home_wins_actual$home_win=1

#
final_pbp1=rbind(road_wins_actual,home_wins_actual)
final_pbp1$home_win=as.factor(final_pbp1$home_win)
final_pbp1$SCOREMARGIN[is.na(final_pbp1$SCOREMARGIN)] <- 0
write.csv(final_pbp1,file="final_pbp1.csv")

# home_win, SCOREMARGIN, time 

#assign player_id (as home or road)?
final_pbp1=read.csv("final_pbp1.csv")
final_pbp2=subset(final_pbp1,select=c("home_win","SCOREMARGIN","time","GAME_ID"))
final_pbp2$GAME_ID=as.factor(final_pbp2$GAME_ID)
final_pbp3=final_pbp2[!(final_pbp2$SCOREMARGIN==0),]

#logistic regression model 
model1=glm(as.factor(home_win)~time+SCOREMARGIN,
           data=final_pbp3,family=binomial)

summary(model1)
final_pbp3$win_prob=predict(model1,final_pbp3,type="response")

#subset two game ids (for plotting)
game_id=subset(final_pbp3,GAME_ID=="21700897") #hawks vs. lakers 
game_id1=subset(final_pbp3,GAME_ID=="21700886") #knicks vs. celtics 

#create a time series (time vs. home win prob) 
ggplot(game_id,aes(x=time,y=win_prob))+geom_line(color="red")+xlab("time (seconds)")+
  ylab("Home Win Probability") #hawks (home) vs. lakers (road)

ggplot(game_id1,aes(x=time,y=win_prob))+geom_line(color="green")+xlab("time (seconds)")+
  ylab("Home Win Probability") #knicks (home) vs. celtics (road)



