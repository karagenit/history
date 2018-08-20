#!/usr/bin/env Rscript

library("rjson")

totals = fromJSON(file = "output/totals.json")
commands = names(totals)[1:5]

dates = fromJSON(file = "output/dates.json")
colors = c("darkgreen", "blue", "red", "black", "orange")

x11()

# Setup plot & axis
commands.data = c()
for (command in commands) {
    commands.data = c(commands.data, dates[[command]])
}
commands.data = commands.data[!duplicated(names(commands.data))]
commands.data = data.frame(unlist(commands.data))
commands.data$Date = as.Date(rownames(commands.data), "%Y-%m-%d")
colnames(commands.data) = c("Count", "Date")
rownames(commands.data) = c()
commands.data = commands.data[order(commands.data$Date),]

plot(Count ~ Date,
     commands.data,
     xaxt="n",
     yaxt="n",
     type="n",
     main="Command Usage Over Time")
axis(2,
#    commands.data$Count,
     lwd = 0,
     lwd.ticks = 1,
     at = seq(0, 900, 100)) # TODO: don't hardcode
axis(1,
     commands.data$Date,
     format(commands.data$Date, "%b %d"),
     lwd = 0,
     lwd.ticks = 1,
     cex.axis = .7)

# Plot points
for (i in 1:length(commands)) {
    command = commands[i]
    color = colors[i]

    command.data = data.frame(unlist(dates[[command]]))
    command.data$Date = as.Date(rownames(command.data), "%Y-%m-%d")
    colnames(command.data) = c("Count", "Date")
    rownames(command.data) = c()
    command.data = command.data[order(command.data$Date),]
    points(command.data$Date,
           command.data$Count,
           type="o",
           col=color)
}

legend(x = "topright",
       legend = commands,
       col = colors,
       lty = 1,
       bty = "n",
       cex = 0.8)

dev.print(png, "output/dates.png", width=800, height=500)

Sys.sleep(1000)
