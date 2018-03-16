#!/usr/bin/env Rscript

library("rjson")

# This is a list of dataframes
data <- fromJSON(file = "results.json")

# Magically converts this to one dataframe - thanks SO
top = do.call("rbind", data$totals)

print(top);

# Let's just plot the first 10 rows
top = top[1:10,]

x11()
barplot(top, main = "Most Popular Bash Commands", ylab = "# of Recorded Uses in .bash_history")
dev.print(png, "results.png", width=500, height=500)
Sys.sleep(1000)
