# "Linguistics 337 : Methods of Design+Analysis"
# "R workshop 2: Tidy data + data wrangling"
# "K.Bott / K. Becker"
# "15 October 2020"

## Warm up: review and exploring a new dataset
library(tidyverse)
pnw <- read_csv("/Users/bottk/Downloads/pnw_extract.csv")

# take a look
View(pnw)

### reshape with `pivot_longer()`

#check help documentation to learn more
?pivot_longer

# tidy data + calm down MeanBott.
pnw_tidy <- pnw %>%
  pivot_longer(cols=starts_with("F"), 
               names_to = "formant", 
               values_to = "Hz")

# look @ results
View(pnw)
View(pnw_tidy)

### reshape with `pivot_wider()`

# help docs
?pivot_wider()

# pivot!
pnw_wider <- pnw_tidy  %>%
  pivot_wider(names_from = "formant",
              values_from = "Hz")

# compare your three datasets
View(pnw)
View(pnw_tidy)
View(pnw_wider)

# Expanding datasets with `bind_rows()` and `bind_cols()`
### adding observations with `bind_rows()`

#### Your turn
# 1. Load in the `pnw_extract_extra.csv` data and name it `pnw_extra`
# 2. Note how many observations you have in the "extra" data
# 3. Take a look at the data using `View()`

### combine w bind_rows()
pnw_all <- bind_rows(pnw, pnw_extra)

### your turn
# Take a look at your combined data.
# How many observations do you have in the final dataset? Does that match your expectation?
  
### adding variables with `bind_cols()`

# Start by reading in `pnw_extract_dur.csv`
pnw_dur <- read_csv("/Users/bottk/Downloads/pnw_extract_dur.csv")

# ...then take a look at the data
View(pnw_dur)

# ...and use `bind_cols()` to combine the datasets
pnw_final <- bind_cols(pnw_all, pnw_dur)

# ...and take a look at the resulting data
View(pnw_final)

########
## STOP and go read the discussion of other data wrangling tools in PDF

######
## bonus section / challenges

# Working with the `pnw_final` dataset we created above:

### group_by() + summarize()

# Overall F1 and F2 values aren't terribly useful; we want to work with the data broken into _groups_ by vowel and then calculate _average_ F1 and F2 values. Below, we _group by vowel_ and then _calculate means_ for both F1 and F2. (The `arrange()` command orders our output by `vowel`.)
                                                                                                   vowel_summary <- pnw_final %>%
  group_by(vowel) %>% 
  summarise(meanF1 = mean(F1), meanF2 = mean(F2)) %>%
  arrange(vowel)
                                                                                                   #### your turn
# calculate mean values of variable `duration` for different vowels in the pnw_final data

# calculate mean values of `F1` and `F2` for different _words_ in the pwn_final data
                                                                                               
### mutate()
# Use verb `mutate()` to create a new variable, `F2norm`, which is equal to the difference between F2 and F1.
                                                                                                   
### filter() and select()
# Create a new dataset only containing observations related to vowel "AA"

# Create a new dataset containing onbsrevations of vowel "AA" _and_" vowel "AH"
##### (hint: think about your "and" logic ... and "or" logic. Most people set this up backwards the first time through; feel free to check-in with KBott)

# Create a new dataset that does not contain F3.

# Create a new dataset that contains everything _except_ F3. (Or, "Accomplish what you just did again, but using different code.")