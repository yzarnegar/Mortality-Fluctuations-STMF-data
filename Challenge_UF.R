

####Step 1
myString <- "Hello world!"


#################################
####Step 2 ### exploring the data
#################################
mortality<-read.csv(file = '/Users/yaldazarnegarnia/Documents/U_o_F/stmf.csv',skip=2)
o1<-names(mortality)
o2<-summary(mortality)
attach(mortality)
o3 <- table(Sex,CountryCode) # Check that same number of time from 1999-2020 the death ststus being considered for different sex groups
DF <- mortality[,c('Sex','CountryCode')]
DF$TotalDeath <- ave(DTotal,DF,FUN=sum)
DF$TotalDeathRate <- ave(RTotal,DF)
# remove the duplicates (keep only one row for each group)
DF <- DF[!duplicated(DF),]

sink("/Users/yaldazarnegarnia/result1.txt")
print (myString)
cat("\n")
cat("Human Mortality data Statistics:")
cat("\n")
o1
cat("Check that same number of time from 1999-2020 the death status being considered for different sex groups")
cat("\n")
o2
cat("\n")
cat("Death rate and total death averages for different countries and sex groups")
cat("\n")
DF
sink()
#######some explanatory plots#######
####Trend of death rate along the years for sex gropus
#####################################################
library(ggplot2)
d1=subset(mortality, mortality$Year<=2020)  
d1$year=d1$Year+d1$Week/52
p1=ggplot(d1, aes(x = year, y = RTotal)) + 
  geom_point(aes(color =CountryCode )) + xlab('Year')+ylab('Total Death Rate')+
  ggtitle("Trend of total death rate along years 1990-2020 for different sex groups")+
  theme_minimal()
####  Trend of death rate along the years for different countries and sex gropus 
p2=ggplot(d1, aes(x = year, y = RTotal,size=CountryCode)) + 
  geom_point(aes(color = Sex)) + xlab('Year')+ylab('Total Death Rate')+
  ggtitle("Trend of total death rate along years 1990-2020 for different different countries and sex groups")+
  theme_minimal() 
####  Trend of average death rate along the weeks for different countries and sex gropus   
p3=ggplot(d1, aes(x = Week, y = RTotal)) + 
  geom_point(aes(color = Sex)) + xlab('Week')+ylab('Total Death Rate')+
  ggtitle("Trend of average total death rate for weeks based on different sex groups")+
  theme_minimal()
####  Trend of death rate for age group 15-64 along the years for different countries and sex gropus for years 2000-2020 
d2=subset(mortality, mortality$Year>=2000)  
d2$year=d2$Year+d2$Week/52      
p4=ggplot(d2, aes(x = year, y = R15_64,color=CountryCode)) +
 geom_point(aes(size = Sex)) + xlab('Year')+ylab('Total Death Rate')+
 ggtitle("Trend of total 15-64 age group death rate for different countries and sex groups for years 2000-2020")+
 theme_minimal()  
 
####  Trend of death rate for group age 15-64 for year 2020 for different countries and sex gropus    
d2=subset(mortality, mortality$Year>=2020)  
d2$year=d2$Year+d2$Week/52 
p5=ggplot(d2, aes(x = year, y = R15_64,color=CountryCode)) +
 geom_point(aes(size = Sex)) + xlab('Year')+ylab('Total Death Rate')+
 ggtitle("Trend of total 15-64 age group death rate for year 2020 for different countries and sex groups")+
 theme_minimal() 

####  Trend of death rate for group age 65-74 for year 2020 for different countries and sex gropus    
 
p6=ggplot(d2, aes(x = year, y = R65_74,color=CountryCode)) +
 geom_point(aes(size = Sex)) + xlab('Year')+ylab('Total Death Rate')+
 ggtitle("Trend of total 65-74 age group death rate for year 2020 for different countries and sex groups")+
 theme_minimal() 

pdf('/Users/yaldazarnegarnia/plots1.pdf')
par(mfrow=c(3,2))
p1
p2
p3
p4
p5
p6 
dev.off()
#####################################################
#####USA Data######
####Trend of death rate for group age 15-64 along the years for USA and sex gropus    
d3=subset(mortality, mortality$CountryCode== 'USA' & mortality$Year<=2020)  
d3$year=d3$Year+d3$Week/52
p7=ggplot(d3, aes(x =year, y = RTotal,color= Sex)) + 
  geom_point(aes(size =CountryCode)) + xlab('Year')+ylab('Total Death Rate')+
  ggtitle("Trend of total death rate along years 2013-2020 for USA")+
  theme_minimal()

####  Trend of death rate for group age 15-64 for year 2020 for USA and sex gropus  
d4=subset(mortality, mortality$CountryCode=='USA' & mortality$Year>=2020)   
d4$year=d4$Year+d4$Week/52
p8=ggplot(d4, aes(x = year, y = R15_64,color=Sex)) +
  geom_point(aes(size = CountryCode)) + xlab('Year')+ylab('Total Death Rate')+
  ggtitle("Trend of total death rate for 15-64 age group for USA based on different sex groups")+
  theme_minimal()  

#####################################################  
########## Summary statistics for USA
#####################################################
DF_USA <- d3[,c('Sex','Year')]
DF_USA$TotalDeath <- ave(d3$DTotal,DF_USA,FUN=sum)
DF_USA$TotalDeathRate <- ave(d3$RTotal,DF_USA)
# remove the duplicates (keep only one row for each group)
DF_USA <- DF_USA[!duplicated(DF_USA),]
susa<- summaryTable(d3, mvar="RTotal", gvars=c("Year","Sex"))

#### error bar plot for trend of total death rate along years 2013-2020 for USA for different sex groups
p9=ggplot(susa, aes(x = Year, y = RTotal )) +  geom_errorbar(aes(ymin= RTotal-se, ymax= RTotal+se), width=.1)+
  geom_line(aes(color = Sex), size = 1) + xlab('Year')+ylab('Total Death Rate')+
  ggtitle("Trend of total death rate along years 2013-2020 for USA for different sex groups")+
  theme_minimal()

pdf('/Users/yaldazarnegarnia/plots2.pdf')
par(mfrow=c(3,1))
p7
p8
p9
dev.off()

sink("/Users/yaldazarnegarnia/result_USA.txt")
cat("Summary statistics for USA")
cat("USA total death and mortality rate ")
DF_USA 
cat("\n")
susa
sink()
## Summarizes data.
## count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%).
##   data: a data frame.
##   mvar: variable to be summariezed
##   gvars:  grouping variables
##   na.rm:  whether or not to ignore NA's
##   conf.interval: the percent range of the confidence interval (default is 95%)
summaryTable<- function(data=NULL, mvar, gvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
    library(plyr)

    #  if na.rm==T, don't count them
    findmis <- function (x, na.rm=FALSE) {
        if (na.rm) sum(!is.na(x))
        else       length(x)
    }

    # gettimg the summeries
    datas <- ddply(data, gvars, .drop=.drop,
      .fun = function(xx, col) {
        c(N    =  findmis(xx[[col]], na.rm=na.rm),
          mean = mean   (xx[[col]], na.rm=na.rm),
          sd   = sd     (xx[[col]], na.rm=na.rm)
        )
      },
      mvar
    )

    # Rename the "mean" column    
    datafinal <- rename(datas, c("mean" = mvar))

    datafinal$se <- datafinal$sd / sqrt(datafinal$N)  # Calculate standard error of the mean

    # Confidence interval multiplier for standard error
    # Calculate t-statistic for confidence interval (df=N-1): 
 
    ciMult <- qt(conf.interval/2 + .5, datafinal$N-1)
    datafinal$ci <- datafinal$se * ciMult

    return(datafinal)
}  

##########Data anlysis considering all the countries
#####################################################
library (lmerTest) # Mixed model package
library (texreg) #Helps us make tables of the mixed models
library (afex) # Easy ANOVA package to compare model fits
library (plyr) # Data manipulator package


d5=subset(mortality , mortality$Year<=2020)  
d5$year=d5$Year+d5$Week/52

nullmodel1 <- lmer( RTotal ~ 1 + (1|CountryCode ), data = d5, REML=FALSE)
nullmodel2 <- lmer( RTotal ~ 1 + (1 + factor(Sex) |CountryCode ), data = d5, REML=FALSE)
nullmodel3 <- lmer( RTotal ~ 1 + (1 + factor(Sex)+ Week |CountryCode ), data = d5, REML=FALSE)
#summary(nullmodel1)
#summary(nullmodel2)
#summary(nullmodel3)
out1=anova (nullmodel1, nullmodel2, nullmodel3)

d6 <- within(d5, Sex<- relevel(Sex, ref = 'f'))
m1=lmer( RTotal ~ factor(Sex) + (1 + factor(Sex) |CountryCode ), data = d6, REML=FALSE)
out2=summary(m1)
m2=lmer( RTotal ~ factor(Sex)+ Week + (1 + factor(Sex)+ Week |CountryCode ), data = d6, REML=FALSE)
out3=summary(m2)
m3=lmer( RTotal ~ factor(Sex)* Week + (1 + factor(Sex)+Week |CountryCode ), data = d6, REML=FALSE)
out4=summary(m3)

out5=anova (m1, m2, m3)

####Data anlysis considering all the countries for age group 15-64, 65-74 and 75-84 
m4=lmer( R15_64 ~ factor(Sex)+ Week + (1 + factor(Sex)+Week |CountryCode ), data = d6, REML=FALSE)
out6=summary(m4)
m5=lmer( R65_74 ~ factor(Sex)+ Week + (1 + factor(Sex)+Week |CountryCode ), data = d6, REML=FALSE)
out7=summary(m5)
m6=lmer( R75_84 ~ factor(Sex)+ Week + (1 + factor(Sex)+Week |CountryCode ), data = d6, REML=FALSE)
out8=summary(m6)

sink("/Users/yaldazarnegarnia/result2.txt")
cat("random effect modeling considering all the countries:")
cat("\n")
out1
cat("\n")
out5
cat("\n")
out3
cat("\n")
out8
sink()

dnew=subset(mortality , mortality$Year>=2020)  
p=predict(m2,dnew)
dnew$Week


#############Prediction for remaining months of 2020#####
#########################################################
u=unique(d5$CountryCode)
dnew<-data.frame(CountryCode = rep(u,3*52),Sex=c(rep('m',30*52),rep('f',30*52),rep('b',30*52)),Week=rep(1:52,each=30),Year=rep(2020,90))
dnew2=subset(dnew,dnew$CountryCode=='USA' & dnew$Week>32) 
p=predict(m6,dnew2)
final=data.frame(p, dnew2$Week,dnew2$Sex)
names(final)=c('p','Week','Sex')
p10=ggplot(final, aes(x = Week, y = p)) +
  geom_point(aes(color =Sex))+xlab('Week')+ylab('Predicted Death Rate')+
  ggtitle("Predicted death rate for USA for remaining weeks of the year 2020 for 75-84 age group")+
  theme_minimal()  
  
pdf('/Users/yaldazarnegarnia/plots3.pdf')
par(mfrow=c(3,1))
p10
dev.off()

####################################################################################
