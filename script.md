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
  - it is always good idea to check the extremes, the following code shows top and bottom countries and cities.
  - try and refactor it on your own
  - ...
  - let's discuss. here we had quite clear duplications
  - first I alter the code to make refactoring easier: return top and bottom rowbinded in one data frame
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

## 2

## 3

## 4
