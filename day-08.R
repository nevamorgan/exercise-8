#Neva Morgan
#Date: 2025-02-24
#Purpose: Exercise 8 | ESS330 - Quantitative Reasoning for Ecosystem Science

``

#Question 1: Make a faceted plot of the cumulative cases & deaths by USA region.
#Your x axis should be the date and the y axis value/count. To do this you will
#need to join and pivot the COVID-19 data.

##We can break this task into 7 steps:

###1. Read in the COVID-19 data
###2. Create a new data.frame using the available state.abb, state.name,
#state.region objects in base R. Be intentional about creating a primary key to
#match to the COVID data!

``
library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties-recent.csv'
covid = read_csv(url)
 df = data.frame(region = state.region,
                 abb = state.abb,
                 state = state.name)
head(df)
 inner_join(df, covid, by = "state") |>
   group_by(region, date) |>
   summarize(cases = sum(cases),
             deaths = sum(deaths)) |>
   pivot_longer(cols = c(cases, deaths),
                names_to = "situation",
                values_to = "count") |>
   ggplot(aes(x = date, y = count)) +
   geom_line() +
   facet_grid(situation~region, scales = "free_y") +
   labs(x = "Date", y = "Count",
        title = "COVID-19 Case Data in U.S. Regions",
        subtitle = "Data Comprised: Feb 2, 2023 - March 3, 2023",
        caption = "ESS330 Exercise 8 Neva Morgan") +
   theme_bw() +
   theme(legend.position = "none") +
   theme(axis.text.x = element_text(angle = 90, face = "bold")) +
   theme(plot.subtitle = element_text(color = "navy", face = "bold"))

``
###3. Join your new data.frame to the raw COVID data. Think about right, inner,
###   left, or full join…
###4. split-apply the joined data to determine the daily, cumulative, cases and
###   deaths for each region
###5. Pivot your data from wide format to long
###6. Plot your data in a compelling way (setup, layers, labels, facets, themes)
###7. Save the image to your img directory with a good file name and extension!
