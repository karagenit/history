#!/usr/bin/env Rscript

library("rjson")

totals <- fromJSON(file = "totals.json")
totals = do.call("rbind", totals)
top = totals[1:10,]

x11()
barplot(top,
        main = "Most Popular Bash Commands",
        ylab = "# of Recorded Uses in .bash_history",
        col = "black",
        density = 30)
#dev.print(png, "results.png", width=600, height=500)

dates <- fromJSON(file = "dates.json")
command = "git"
command.data = dates[[command]]

command.data = data.frame(unlist(command.data))
command.data$Date = as.Date(rownames(command.data), "%Y-%m-%d")
colnames(command.data) = c("Count", "Date")
rownames(command.data) = c()
command.data = command.data[order(command.data$Date),]

x11()
plot(Count ~ Date, command.data, xaxt="n", type="o")
axis(1, command.data$Date, format(command.data$Date, "%b %d"), cex.axis = .7)

Sys.sleep(1000)
