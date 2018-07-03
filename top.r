#!/usr/bin/env Rscript

library("rjson")

totals <- fromJSON(file = "output/totals.json")
totals = do.call("rbind", totals)
top = totals[1:10,]

x11()
barplot(top,
        main = "Most Popular Bash Commands",
        ylab = "# of Recorded Uses in .bash_history",
        col = "black",
        density = 30)
dev.print(png, "output/totals.png", width=600, height=500)

Sys.sleep(1000)
