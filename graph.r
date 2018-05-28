#!/usr/bin/env Rscript

library("rjson")

totals <- fromJSON(file = "totals.json")
totals = do.call("rbind", totals)
top = totals[1:10,]

x11()
barplot(top, main = "Most Popular Bash Commands", ylab = "# of Recorded Uses in .bash_history")
#dev.print(png, "results.png", width=600, height=500)

dates <- fromJSON(file = "dates.json")
command = "git"
command.data = dates[[command]]

command.data = data.frame(unlist(command.data))
rownames(command.data) = as.Date(rownames(command.data), "%Y-%m-%d")

Sys.sleep(1000)
