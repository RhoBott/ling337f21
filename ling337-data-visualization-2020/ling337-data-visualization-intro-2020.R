## data visualization introduction
## ling 337 - fall 2020
## k.bott + k.becker @ reed college

### data visualization
# today we'll work across a number of datasets / libraries

## load libraries
library(ggplot2)
library(readr)
library(dplyr)
library(nycflights13)
library(gapminder)

# missing something? install.packages as needed
## command is install.packages("name-of-package")

# load data
## some of these datasets are built in to the packages you've loaded
data(anscombe)
data(flights)
data(weather)

becker_data <- read_csv("/Users/bottk/Downloads/beckerData.csv")
pnw_extract <- read_csv("/Users/bottk/Downloads/pnw_extract.csv")

## basics of ggplot (three elements)
## ggplot = data + aes(thetics) + geom(etry)
## ## can get a lot fancier, but that's the general idea.

# why data visualization?

## to play this game **only** run your assigned code (please)

# everyone run
summary(anscombe)

## examine "measures of central tendency" (mean, median) for x's and y's
## these data are in pairs -- (x1,y1) / (x2,y2) -- etc

# discussion
## then ... when ready ::

# keeley
ggplot(data = anscombe, aes(x = x1, y = y1)) +
  geom_point()

# gregory
ggplot(data = anscombe, aes(x = x2, y = y2)) +
  geom_point()

# m
ggplot(data = anscombe, aes(x = x3, y = y3)) +
  geom_point()

# kara
ggplot(data = anscombe, aes(x = x4, y = y4)) +
  geom_point()

### ### draw general shape on zoom board and/or mime it if the board is too awkward


############### five main graphs (aka "five named graphs", after _modern dive_ (kim/ismay))

### ### below - five main graphs -- these should cover MOST ground for what you need to do (in this class and in general)


########################################################################
#################### histogram
## one variable

###  working with weather data
### going to be working with nycflights13 stock dataset
### flights into+out of 3 NYC-area airports in 2013 + related weather

View(weather)

### basic histogram
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram()

### add a color argument
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(color="white")

### note that fill does something different
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(fill="white")

### weird bin warning, huh? let's try again. adjust number of bins
##### notice what this does to your visual

ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(bins = 60, color = "white")

## ## 
## copy/paste the above code and try at least three values of "bins"
## pick a value of "bins" that appeals to you


### "small multiples" can be useful here...
## ## adjust your bin# as needed

ggplot(data = weather, aes(x = temp)) +
  geom_histogram(bins = 30, color = "white") +
  facet_wrap(~ month, nrow = 4)

## ## ## your turn ## ## ##
## working with becker_data

## (1) create a histogram that shows how age is spread out across the dataset
## (2) double-check that you like your bin distribution
## (3) ... then break that up by city

####################################
################## line graph
## two continuous variables OR time series, generally over time

## still thinking about flights... how does temperature shift over the course of the day?

### focus just on the *first half of* january, and Newark only. 
early_january_weather <- weather %>% 
  filter(origin == "EWR" & month == 1 & day <= 15)

ggplot(data = early_january_weather, aes(x = time_hour, y = temp)) +
  geom_line()

## a note on syntax -- you can also include the filter() in your ggplot call
## the below code generates the _same_ graph as above
## in the below, i pipe ( %>%) the data to the ggplot call instead of saying "data =" within the call

weather %>%
  filter(origin == "EWR" & month == 1 & day <= 15) %>%
  ggplot(aes(x = time_hour, y = temp)) +
  geom_line()

####################################
######### scatterplot
## two continuous variables

## for this graph, let's focus on Alaska Air only
all_alaska_flights <- flights %>% 
  filter(carrier == "AS")

ggplot(data = all_alaska_flights, aes(x = dep_delay, y = arr_delay)) + 
  geom_point()

### what are we looking at? does that make sense?

### huh sure are a lot of points there. maybe we can clean that up a bit?

## can correct for overplotting with "alpha" (transparency)

ggplot(data = all_alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) + 
  geom_point(alpha = 0.2)

## ## side note #1 -- you can also change the _shape_ of your "geom_point()" as another aesthetic variable

## ## side note #2 -- in previous MDA classes, i have often seen scatterplots (aka scattergrams) as visualizations of F1/F2 formants in vowelspaces. example, using pnw_extract data:

ggplot(pnw_extract, aes(x = F2, y = F1)) +
  geom_point() +
  scale_x_reverse() +
  scale_y_reverse()


####################################
######### barplot
## distribution of categorical variable
#### variations include: stacked barplot - side-by-side barplot

### flights data -- look at carriers
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar()

### can also use color
ggplot(data = flights, mapping = aes(x = carrier, fill = origin)) +
  geom_bar()

### default is stacked barplot. can do side-by-side, too.
ggplot(data = flights, mapping = aes(x = carrier, fill = origin)) +
  geom_bar(position = "dodge")

### compare origin points
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar() + 
  facet_wrap(~origin)

## let's tilt those x-axis variables
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar() + 
  facet_wrap(~origin) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

## ## ## your turn

## using becker_data

## (1) create a bar graph examining education levels across the whole dataset
## (2) create a bar graph examining education levels within cities
## (3) create a bar graph examining education levels within cities, accounting for gender

## ## bonus: these categorical variables are in alphabetical order in your graph
## look back at previous labs to reorder them



####################################
######## boxplot
## shows 'five-number summary', range of data, and outliers

## boxplot!
ggplot(data = weather, aes(x = month, y = temp)) +
  geom_boxplot()

## it said it wanted a group() argument, okay...
ggplot(data = weather, aes(x = month, y = temp, group = month)) +
  geom_boxplot()

### ... that's still weird.
## ## remember a discussion of factors? <-- categorical data
ggplot(data = weather, mapping = aes(x = factor(month), y = temp)) +
  geom_boxplot()


## ## ### your turn
## becker_data

##  (1) create a boxplot of age across the dataset (note: this may be .... problematic. move on!)

## (2) break this apart by city

## (3) repeat what you did above, but break things out by _education level_ instead of geography


# --------------------------------------------------------
## ### ## additional challenges

## (1) summary stats (not graphing)

## review earlier days of R -- working with becker_data

## (a) how many respondents of each gender designation do we have in our sample, total?
## (b) by city?
## (c) by education level?


## (2) data wrangling meets graphing

## working with the pnw_extract data, return to the F1/F2 scattergram above
## (a) re-create this for a particular vowel of interest (hint -- subset rows)
## (b) re-create this, comparing across more than one vowel (how many, up to you)


## (3) scatterplots, revisited

## working with gapminder data (global wealth + health over time)
## (a) filter the data to only the most recent (year 2007) data,
## (b) ... then create a scatterplot that compares life expectancy and GDP per capita
## (c) ... then create new graph, split this out by continent (somehow)
## (d) ... if you choose, investigate further (more time? specific continents? countries?)


## (4) revisit anything _but_ the scattergram above ...

## (a) try graphing something from a different dataset?
## (b) explore a variable that we have not looked at in this exercise?
## (c) play with different ways of grouping your variables visually for any graph we've made?
## (d) there are MANY options for colors, for labeling axes, for legends... dive in?


## (5) linegraphs + gapminder data

## (a) make ANY linegraph using the gapminder data
## (b) make a linegraph by continent using some variable
## (c) repeat, but now also considering country (you may subset data if you so choose)


## (6) FYI - geom_bar() and geom_col()
### geom_bar() and geom_col() are closely related

# curious re differences? see :: https://moderndive.netlify.com/2-viz.html#barplots-via-geom_bar-or-geom_col
# the below gives you the same result
ggplot(data = gapminder, aes(x = continent, y = gdpPercap, fill = continent)) +
  geom_bar(stat="identity")

## ...as this code
ggplot(data = gapminder, aes(x = continent, y = gdpPercap, fill = continent)) +
  geom_col()