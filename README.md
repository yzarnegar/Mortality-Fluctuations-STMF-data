# Mortality-Fluctuations-STMF-data

This report is provided for data from the Human Mortality Database (HMD) which was created to provide mortality and population data from different coutries around the world to researchers, policy analysts, and others interested in the history of human longevity. (https://www.mortality.org)

Step  1:
[1] "Hello world!"

Step 2:

#Some statistics including frequesncy of data for different countries, the year and week statistics and sex groups counts.

<img width="373" alt="Screen Shot 2020-08-30 at 3 53 46 PM" src="https://user-images.githubusercontent.com/57342758/91672051-af217200-eae0-11ea-9100-fca7b8db0a5f.png">

#Total number of listings for different sex groups and countries

<img width="860" alt="Screen Shot 2020-08-30 at 4 52 40 PM" src="https://user-images.githubusercontent.com/57342758/91672155-6f0ebf00-eae1-11ea-87b3-16c64f4a95fe.png">
Maximum number of avilable data is for country NLD (Netherlands) and minimum number of data is available for DEUTNP (Germany).

#Trend of total death rate along years 1990-2020 for different sex groups
<img width="1194" alt="Screen Shot 2020-08-30 at 5 08 04 PM" src="https://user-images.githubusercontent.com/57342758/91672986-8c925780-eae6-11ea-8c04-760ac4d6c278.png">
There are a lot of fluctiations for death rate. It seems that total death rate has decreased at some points and again increased for different Sex groups and in general it has been higher for males than females. 

#Trend of total death rate along years 1990-2020 for different countries
<img width="1314" alt="Screen Shot 2020-08-30 at 5 32 03 PM" src="https://user-images.githubusercontent.com/57342758/91673029-c8c5b800-eae6-11ea-8086-66017ac28dc4.png">
Total death rate has decreased for some contries and remained unchanged or increased for some. Now lets take a look at the mortality rate trend for age group 15-64 for years 2000-2020 and differet sex groups as data is not available for many countries before 2000 .
<img width="1322" alt="Screen Shot 2020-08-30 at 5 49 51 PM" src="https://user-images.githubusercontent.com/57342758/91673504-4094e200-eae9-11ea-8f39-c02e3845170e.png">

It can be seen that death rate for age group 15-64 has been declined since 2000 but became higher for 2020 which could be because of Covid19.
Lets take a look at just year 2020 to see how is death tend for this year.
<img width="1321" alt="Screen Shot 2020-08-30 at 5 49 12 PM" src="https://user-images.githubusercontent.com/57342758/91673512-4be80d80-eae9-11ea-90f7-1d8670a08ae0.png">

As far as data is available, theres have been mortality rate flactuations for most of the countries. For USA, it has increased during the spring and decresed after that. For countries such as Norway, Nethurland, Swiserland and Poland the death rate has been lower compared with other countries since the beggining of the pandemic for  age group 15-64. For countries such as USA and Italy the death rate has been higher for males compared with females. Similar pattern can be seen for age group 65-74 in following plot.
<img width="1323" alt="Screen Shot 2020-08-30 at 6 01 36 PM" src="https://user-images.githubusercontent.com/57342758/91673838-e432c200-eaea-11ea-9281-de92ce0f8a26.png">

Now lets just focus on USA data. Considering the following plots, death rate along the years has been higher for males compared with females and it has been lower during the summer time and increases toward the winter as perhapse could be because of the Flu season. For 2020, there was a jump in death rate due to Covid19 during the spring and then it has lowered down.

<img width="1323" alt="Screen Shot 2020-08-30 at 6 03 14 PM" src="https://user-images.githubusercontent.com/57342758/91674374-41c80e00-eaed-11ea-9968-8ce4d2dd2ef1.png">
<img width="1325" alt="Screen Shot 2020-08-30 at 6 04 12 PM" src="https://user-images.githubusercontent.com/57342758/91674379-468cc200-eaed-11ea-8446-7c6f5fe6c173.png">

Following, there are some statistics for mortality rate for USA for different years and sex groups. The average death rate has increased slightly but higher for males and then there is a jump for 2020 due to Covid19.

<img width="433" alt="Screen Shot 2020-08-30 at 6 26 15 PM" src="https://user-images.githubusercontent.com/57342758/91674672-843e1a80-eaee-11ea-9c76-87556b621a08.png">
<img width="1224" alt="Screen Shot 2020-08-30 at 6 28 29 PM" src="https://user-images.githubusercontent.com/57342758/91675852-b3568b00-eaf2-11ea-9b9f-068737d2a9b6.png">

Now considering the initial insights from data and some seen patterns lets do some analysis to see if the effect of the time of the year (Weeks) and sex has statistically significant relation with mortality rate. Based on the trend of death along years, it is expected to see higher death rate toward the end of the 2020 and beggining of 2021. Studies that obtain multiple measurements alomg time such as time series data lend themselves well to mixed model analyses.


In order to fit best random effect model, three hypothetical random effects structures are being considered and anova function is used to find the best fitting random effects structure. Random effect models are as follows:

nullmodel1 <- lmer( RTotal ~ 1 + (1|CountryCode ), data = d5, REML=FALSE)
nullmodel2 <- lmer( RTotal ~ 1 + (1 + factor(Sex) |CountryCode ), data = d5, REML=FALSE)
nullmodel3 <- lmer( RTotal ~ 1 + (1 + factor(Sex)+Week |CountryCode ), data = d5, REML=FALSE)

<img width="493" alt="Screen Shot 2020-08-31 at 7 43 02 AM" src="https://user-images.githubusercontent.com/57342758/91732861-ad49c400-eb5d-11ea-891d-355d446e4d5b.png">

Considering the result from  anova, models 2 and 3 are statsitically significant. However, model 3 is chosen as it has smaller AIC. 
Potential fixed effects now can be added to the model.  Three following model will be compared using anova function:

m1=lmer( RTotal ~ factor(Sex) + (1 + factor(Sex) |CountryCode ), data = d6, REML=FALSE)
m2=lmer( RTotal ~ factor(Sex)+ Week + (1 + factor(Sex)+ Week |CountryCode ), data = d6, REML=FALSE)
m3=lmer( RTotal ~ factor(Sex)* Week + (1 + factor(Sex)+Week |CountryCode ), data = d6, REML=FALSE)

<img width="495" alt="Screen Shot 2020-08-31 at 7 51 20 AM" src="https://user-images.githubusercontent.com/57342758/91733762-d7e84c80-eb5e-11ea-9b0c-672acafdcfd3.png">

Considering the anova results model 2 is the best fit:

<img width="513" alt="Screen Shot 2020-08-31 at 8 08 41 AM" src="https://user-images.githubusercontent.com/57342758/91735530-4a5a2c00-eb61-11ea-909b-f988d381b7f2.png">

There is significant difference between males and females in terms of mortality rate and week also has significant effect on mortality. However if we break down the age group the week effect is significant only for age groups 75-84 and +85. Following is the result for age 75-84:


<img width="515" alt="Screen Shot 2020-08-31 at 10 52 26 AM" src="https://user-images.githubusercontent.com/57342758/91751522-bfd1f680-eb79-11ea-8d33-418da4eca07b.png">

This makes sence as elderly citizens are more valunerable to disease such as flu and there will be more deaths during the flu season.
Now lets do some mortality rate predictions for remaining months od 2020 for USA.

<img width="1065" alt="Screen Shot 2020-08-30 at 11 38 27 PM" src="https://user-images.githubusercontent.com/57342758/91752312-096f1100-eb7b-11ea-8716-94bc439d1c5c.png">

Since the 2020 mortality pattern has been different for 2020 compared with previous years so although we expect to see higher mortality rate during the last weeks of the year as before due to flu season but based on model predictions there is not going to be much different from now which perhaps is underestimated due to lack of enough data for more accurate prediction. 

<img width="1090" alt="Screen Shot 2020-08-31 at 11 16 20 AM" src="https://user-images.githubusercontent.com/57342758/91752608-708cc580-eb7b-11ea-80f1-be4c9d0c1b02.png">
















