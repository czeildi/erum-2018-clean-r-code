## Master

- look at the input data
- this is unusually clean data prepared for this workshop. However we should double check its cleanness.
  - first we check for missing values (cmd-enter to run your code)
  - then we check the granularity of location: 1 point per city
- we now have a correct bit of code. can we improve the code?
  - realize it is already quite good
    - meaningful variable names
    - meaningful dataframe column names
    - good code formatting
  - we have duplication --> extract the logic to a function! although only used twice we can expect it will be also useful later. Also, it is not easy to read for an R novice. We not only use the same function twice but have to specify the name of the data frame twice as well.
  - most difficult is to name our function: `get_rows_with_missing_values` quite long but explicit, starts with a verb
  - can be used with any data frame --> the param can be df: in a short scope we can use short names
  - call our function
  - remove old code
  - move function to separate file (cmd-shift-N for new file) in dedicated folder: name your file as well
  - new code has more characters but more readable
  - we could have used cmd-alt-x to extract code but not works very well with code using columns as variable names
  - we have a piece of code whose purpose is not immediately clear, we have to process several lines of code, moreover the calculation details are irrelevant for analysis --> extract this to function
  - choose a name revealing intent: `get_cities_with_multiple_coords`
  - we could have used fetch or retrieve but for consistency we used get for a similar purpose
  - we do not expect to call this function with a different kind of data frame so we keep the argument name
  - ungroup after summarize to make the result cleaner: easier to add more code once it is in a function and does not clutter main analysis script
  - we can move this function  to the same file used before

## 0

- it is always good idea to check the extremes, the following code shows top and bottom countries and cities.
- we attach country metadata because country names are better readable than country codes
- quite clear duplications: two block, only difference is grouping level
- here's an example how to write a function with variable number of arguments: 0, 1, 2, 3
- try and refactor it on your own
- ...
- let's discuss. here we had quite clear duplications
  - first create a big function than split it up to smaller ones
  - name your top-level function: `glimpse_extreme_regions`: new verb to convey that this is not a full result and use general region so we can use it for cities and countries as well
  - keep variable names and add `...` for grouping variables
  - we still have duplication within our function: we can rearrange the code without creating a new function
  - we do quite different things: summarize to group level, select top and bottom, make output more user friendly but using names instead of codes --> create functions for these responsibilities
  - makes it easier to expand the human readable part
  - refactor even the smallest duplication as you will most likely modify it later
  - even the two line function `attach_human_readable_country_metadata` contains two different pieces of logic in the context of your analysis: how to join two different data sources and what would you like to see in a final report. These can change independently and also the first is very likely to come in handy in other parts of the analysis as well so we should separate them to different functions
- we had a quite big refactor, it is a good idea to restart our r session (cmd shift F10) and rerun our analysis.
- everything looks good, comment out (cmd-shift-c) the last section and proceed to next session

## 1

- visual explorations of data are a good way to find anomalies and have a feeling about our data
- here we plot city and country populations on the map, let's run the code
- we filter the cities so that the plot is faster
- we have two steps for each plot: data preparation and plotting
- refactor it on your own
- ...
- many plotly details: how to create maps with plotly
- one common part of two plots: log colorbar, plotly layers have the plot as first parameter: you can move any set of layers to a function
- create new R files: summarize and visualize, I choose to move metadata to visualize
- some details are good to keep: arbitrary choice of filtering population above >1000
- we can source all functions at one fell swoop
- we could create big functions, now I chose not to as I do not expect to use them again later and it is good to see some details

## 2

- here we explore how centralized a country is by calculating the relative size of the population of its biggest city
- we could already used two functions created previously
- calculation and plotting is already separated which is good
- first refactor the calculation, then the plotting part
- ...
- let's discuss
- the part about relative populations should have nothing to do with different clients so we extract to function from 3rd line
- the variable name forms a good basis for naming our function: `get_population_share_of_top_cities`
  - !! contains different levels of abstractions - határeset hogy érdemes-e függvénybe kiemelni
  - refactor this two 3 additional helper functions
  - helper functions should be below main function
  - ungroup in helper functions: have no unexpected side effects!
- refactor plotting
- we now have duplication between two coutry level plots, which is a logic of how to plot in plotly: you need iso3c codes of countries, this is a low-level detail
- now we can have one chain of 3 steps
- might have created 1 function for 3 steps: good either way
- we had a quite big refactor, it is a good idea to restart our r session (cmd shift F10) and rerun our analysis.
- everything looks good, comment out (cmd-shift-c) the last section and proceed to next session

## 3

- let's look at client metadata: it contains there industry
- this analysis compares in how many countries a client in each industry is present
- we can already use a function we previously created
- let's refactor
- ...
- 3 main parts: summary, metadata, plotting, metadata is relevant for plotting
- again, 1 function in the main script would have been ok as well
- this is a bit extreme, but to show you how to create functions for ggplot2 layers the theme belongs to density
- ggplot2 has a different logic than plotly, + is not actually addition: order matters.

## 4

- we look at industries from another angle: how strong are they compared to each other? to visualize this we look at the relative strength of the eCommerce industry
- we could use 4 previously defined functions, otherwise the code would be much longer!
- use everything we discussed before and refactor it on your own
- ...
- let's discuss
- separate data manipulation and plotting
- now start with the plotting: function is specific --> name should be specific as well: `plot_ecommerce_share`
- we made similar plots before: country level, plot % value, only the column name and title are different --> refactor it to `plot_country_shares`
- we can use `get` to retrieve variable from name as string
- now refactor the data manipulation: two main steps
  - `summarize_industry_population_by_country`
  - `get_population_share_of_industry`: make industry an argument to be explicit and more general at the same time

## Summary of take aways
