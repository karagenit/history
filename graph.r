#!/usr/bin/env Rscript

library("rjson")

# This is a list of dataframes
data <- fromJSON(file = "results.json")

# Magically converts this to one dataframe - thanks SO
top = do.call("rbind", data$totals)

# Let's just plot the first 10 rows
top = top[1:10,]

x11()
barplot(top, main = "Most Popular Bash Commands", ylab = "# of Recorded Uses in .bash_history")
dev.print(png, "results.png", width=600, height=500)

# Delete the totals - we only want the dates
data$totals <- NULL
gitvals = list()

#print(data[[]][["git"]])

# Grab all the 'git' values from the dates
for (key in names(data)) {
    gitvals[[key]] <- data[[key]][["git"]]
}

# Prepare for Graphing - sort by List names
gitvals = unlist(gitvals[order(names(gitvals))])

x11()
barplot(gitvals, main = "Git Usage Over Time")

Sys.sleep(1000)
