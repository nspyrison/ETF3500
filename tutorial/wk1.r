# Moodle ----

# - Hi, I'm Nick, Tut 2/9 of High Dimensional Data Analysis (ETF3500/ETF5500)
# - Consultation hours
# - Schedule/assessment
# - Lectures

## Hopefully you have already:
# - Downloaded R
# - Downloaded R Studio (highly suggested)

## Work through first half of .pdf

# In R ----

# 1) Intro to R Studio, source vs console, env, files.
# 2) File > New Project > name project. (organization and work directories)
# 3) Download "Datasets" from Moodle. Mine is stored to ./data ("." is relative folder path)


#install.packages("ggplot2") ## Download and install once per machine/version
library(ggplot2) ## Once per session
## Sensitive to work directory, project preferred (Alt. Session > Set WD.)
Beer <- readRDS('./data/Beer.rds')


## EDA, Text-base summary functions missing
class(Beer)
Beer ## Already a tibble
View(Beer)
summary(Beer)
skimr::skim(Beer) ## Advanced summary(), requires {skimr}


## Ideally want to have visual summaries too

## qplot Price (lib ggplot2)
qplot(Beer$price)
## Cross tabulation ("Count Table"), rating by origin
table(Beer$rating, Beer$origin)
