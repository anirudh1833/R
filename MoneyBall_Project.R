"Moneyball Book
The central premise of book Moneyball is that the collective wisdom of baseball insiders (including players, managers, coaches, scouts, and the front office) over the past century is subjective and often flawed. Statistics such as stolen bases, runs batted in, and batting average, typically used to gauge players, are relics of a 19th-century view of the game and the statistics available at that time. The book argues that the Oakland A's' front office took advantage of more analytical gauges of player performance to field a team that could better compete against richer competitors in Major League Baseball (MLB).

Rigorous statistical analysis had demonstrated that on-base percentage and slugging percentage are better indicators of offensive success, and the A's became convinced that these qualities were cheaper to obtain on the open market than more historically valued qualities such as speed and contact. These observations often flew in the face of conventional baseball wisdom and the beliefs of many baseball scouts and executives.

By re-evaluating the strategies that produce wins on the field, the 2002 Athletics, with approximately US 44 million dollars in salary, were competitive with larger market teams such as the New York Yankees, who spent over US$125 million in payroll that same season."

"Because of the team's smaller revenues, Oakland is forced to find players undervalued by the market, and their system for finding value in undervalued players has proven itself thus far. This approach brought the A's to the playoffs in 2002 and 2003.

In this project we'll work with some data and with the goal of trying to find replacement players for the ones lost at the start of the off-season - During the 2001-02 offseason, the team lost three key free agents to larger market teams: 2000 AL MVP Jason Giambi to the New York Yankees, outfielder Johnny Damon to the Boston Red Sox, and closer Jason Isringhausen to the St. Louis Cardinals."

"Data - We'll be using data from Sean Lahaman's Website a very useful source for baseball statistics."

batting <- read.csv('C:\\Users\\anmuralidharan\\Documents\\Courses\\Github\\R\\Batting.csv')

head(batting)

str(batting)

"Call the head() of the first five rows of AB (At Bats) column"
head(batting$AB)

"Call the head of the doubles (X2B) column"
head(batting$X2B)

"We need to add three more statistics that were used in Moneyball! These are:

Batting Average
On Base Percentage
Slugging Percentage"

"Batting Average is equal to H (Hits) divided by AB (At Base). So we'll do the following to create a new column called BA and add it to our data frame:"
batting$BA <- batting$H / batting$AB

tail(batting$BA,5)

"Create an On Base Percentage Column"
batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$HBP + batting$SF)

"Creating X1B (Singles)"
batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR

"Creating Slugging Average (SLG)"
batting$SLG <- ((1 * batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR) ) / batting$AB

str(batting)

"Merging Salary Data with Batting Data"
sal <- read.csv('C:\\Users\\anmuralidharan\\Documents\\Courses\\Github\\R\\Salaries.csv')

summary(batting)

batting <- subset(batting,yearID >= 1985)

summary(batting)

"Use the merge() function to merge the batting and sal data frames by c('playerID','yearID')"
combo <- merge(batting,sal,by=c('playerID','yearID'))

summary(combo)

"Analyzing the Lost Players
As previously mentioned, the Oakland A's lost 3 key players during the off-season. We'll want to get their stats to see what we have to replace. The players lost were: first baseman 2000 AL MVP Jason Giambi (giambja01) to the New York Yankees, outfielder Johnny Damon (damonjo01) to the Boston Red Sox and infielder Rainer Gustavo Ray Olmedo ('saenzol01')."

"Use the subset() function to get a data frame called lost_players from the combo data frame consisting of those 3 players."

lost_players <- subset(combo,playerID %in% c('giambja01','damonjo01','saenzol01') )

lost_players

"Since all these players were lost in after 2001 in the offseason, let's only concern ourselves with the data from 2001."
lost_players <- subset(lost_players,yearID == 2001)

lost_players <- lost_players[,c('playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB')]

head(lost_players)

"Final task - Find Replacement Players for the key three players we lost!"

avail.players <- filter(combo,yearID == 2001)

head(combo)

library(dplyr)
avail.players <- filter(combo,yearID==2001)

library(ggplot2)
ggplot(avail.players,aes(x=OBP,y=salary)) + geom_point()

avail.players <- filter(avail.players,salary<8000000,OBP>0)

avail.players <- filter(avail.players,AB >= 500)

possible <- head(arrange(avail.players,desc(OBP)),10)

possible <- possible[,c('playerID','OBP','AB','salary')]

possible

"Can't choose giambja again, but the other ones look good (2-4). I choose them!"
possible[2:4,]

"Great, looks like I just saved the 2001 Oakland A's a lot of money!"