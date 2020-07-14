"Recreation of this plot from https://www.economist.com/graphic-detail/2011/12/02/corrosive-corruption:"

"Import the ggplot2 data.table libraries"
library(ggplot2)
library(data.table)

"Load the csv file"
df <- fread('C:\\Users\\anmuralidharan\\Documents\\Courses\\Github\\R\\Economist_Assignment_Data.csv',drop=1)

head(df)

"Creation of Scatter plot specifying x=CPI and y=HDI and color=Region as aesthetics"
pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region)) + geom_point()
pl

"Change the points to be larger empty circles"
pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region)) + geom_point(size=4,shape=1)
pl

"Addition of trend line"
pl + geom_smooth(aes(group=1))

"Add the following arguments to geom_smooth (outside of aes): method = 'lm' ,formula = y ~ log(x), se = FALSE, color = 'red'"
pl2 <- pl + geom_smooth(aes(group=1),method ='lm',formula = y~log(x),se=FALSE,color='red')
pl2

"Add labels"
pl2 + geom_text(aes(label=Country))

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

pl3

pl4 <- pl3 + theme_bw() 
pl4

"Addition of X and Y Scales"
pl5 <- pl4 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                                limits = c(.9, 10.5),breaks=1:10) 
pl5
pl6 <- pl5 + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                                limits = c(0.2, 1.0))
pl6

"Addition of string as a title."
pl6 + ggtitle("Corruption and Human development")

library(ggthemes)
pl6 + theme_economist_white()