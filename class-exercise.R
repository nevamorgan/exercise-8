
x = name
y = band, plays (intsrument)

inner_join(x, y)

inner_join(band_members, band_instruments, by = "name")


left_join(x, y) - Keith is left out

left_join(band_members, band_instruments, by = "name")

right_join(x, y) - Mick is left out

right_join(band_memebers, band_intruments, by = "name")

full_join(x, y) - Everyone is included (N/A)s apply

full_join(band_memebers, band_intruments, by = "name")

semi_join(x, y) - will keep data from LHS that has a matching x value in the RHS
anti_join(x, y) - will keep data from x,y on LHS that isnt represented in data from RHS

inner_join(y1, y2, by = x('first_name' = 'name'))

/////

  url <- 'https://www2.census.gov/programs-surveys/popest/datasets/2020-2024/state/totals/NST-EST2024-ALLDATA.csv'
read_csv(url) |>
  select(name = NAME, pop2024 = POPESTIMATE2024) |>
  mutate(pop2024_per100k = pop2024 / 100000) ->
  pop

~~~~
covid |>
  filter(date == max(date)) |>
  group_by(state) |>
  summarize(cases = sum(cases, na.rm = TRUE)) |>
  ungroup() |>
  inner_join(pop, by = c("state" = "name")) |>
  mutate(perCapCases = cases / pop2024_per100k) |>
  slice_max(perCapCases, n = 6) |>
  ggplot() +
  geom_col(aes(x = reorder(state, -perCapCases), y = perCapCases)) +
  labs(title = "Covid Cases per 100k (Top States)",
       x = "State",
       y = "Cases per 100k population") +
  theme_linedraw()

~~~~

library(tidyr)

"tidyr" %in% tidyverse_packages()|>


tidyr::pivot_longer() |> - listed information vertically
tidyr::pivot_wider() - combined information that is extended horizontally

table_wide (no relation b/w gdpPercapita and LifeExp)
table_long (added information using - facet_grid(type~country, ...))



