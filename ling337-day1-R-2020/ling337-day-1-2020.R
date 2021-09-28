## linguistics 337
## r/studio intro
## kbott - sept 8 2020
## reed college

## Set-up: Install packages + load libraries
install.packages("tidyverse")
install.packages("gapminder")

library(tidyverse)
library(gapminder)

### Look at your data
gapminder
View(gapminder)
glimpse(gapminder)
head(gapminder)

## Summary measures
gapminder %>%
  count()

gapminder %>%
  count(continent)

gapminder %>%
  summarize(mean(gdpPercap))

## translation -- The above code takes dataframe `gapminder`, sends it to the next line, which is calculates `mean` (a tool within the `summarize` toolset) on specified variable `gdpPercap`.

## other handy tools
# summarize(max())
# summarize(median())
# summarize(var())
# summarize(sd())
# summarize(min())
#  summarize(IQR())

## *your turn*
# Means and medians are differently affected by outliers. Calculate the median GDP per capita and compare the two numbers.

### The power of group_by()
gapminder %>%
  group_by(continent) %>%
  summarize(mean(gdpPercap))

## You could also calculate median for each continent, to compare the mean + median values:
gapminder %>%
  group_by(continent) %>%
  summarize(median(gdpPercap))

## Note that you can use multiple group_by() arguments. Run the below code and consider the output:
gapminder %>%
  group_by(continent, year) %>%
  summarize(median(gdpPercap))

##... that is quite a LOT of numbers. Perhaps it's time to look at some visualization.

## Data visualization

## All ggplots have three component: data + aes(thetics) + geom(etry of the graph).

### Histograms

ggplot(data = gapminder, aes(x = gdpPercap)) +
  geom_histogram(bins = 60)

#### `facet_wrap()`
ggplot(data = gapminder, aes(x = gdpPercap)) +
  geom_histogram(bins = 60) +
  facet_wrap(~continent)

### Boxplots
ggplot(data = gapminder, aes(y = gdpPercap)) +
  geom_boxplot()

ggplot(data = gapminder, aes(x = continent, y = gdpPercap)) +
  geom_boxplot()

## Can you imagine some use for this graphic?
ggplot(data = gapminder, aes(y = gdpPercap)) +
  geom_boxplot() + 
  facet_wrap(~continent)

#########################
## Practice on your own

## Load in data
## ## ## if using desktop, kbott can walk you through how to do this - process is a bit different

## if you are on the server::
## 1. lower right pane ("files") - "upload" datafile to rstudio.reed.edu
## 2. upper right pane ("environment") - choose "import dataset > text(readr)" for CSV's
## 3. the resulting window will preview data for you and show you code it's using. click ok
## 4. the name of your dataframe will be the same as the filename (minus *.csv). rename as needed

# pnw <- read_csv("/Users/bottk/Downloads/pnw.csv")

## look at data, somehow or other
pnw
View(pnw)
glimpse(pnw)
head(pnw)

## summary, overall
summary(pnw)

# Note that some variables are characters (words) -- `vowel` and `word` summaries are counts. Variable `stress` is categorical so the numbers are somewhat meaningless; the rest of the variables have more meaningful numbers.

## sort data
pnw %>%
  arrange(vowel)

## sort descending
pnw %>%
  arrange(desc(pnw))

### Subsetting data

# only above 2000Hz (F2)
f2above2k <- pnw %>%
  filter(F2 > 2000)

# above 2000Hz and also "ER" vowel
ER2k <- pnw %>%
  filter(F2 > 2000 & vowel == "ER")

# above 2000Hz and *not* "ER" vowel
notER2k <- pnw %>%
  filter(F2 > 2000 & vowel != "ER")
