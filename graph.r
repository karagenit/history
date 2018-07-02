#!/usr/bin/env Rscript

library("rjson")

# TOTALS STUFF

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

# BY DATE STUFF

dates <- fromJSON(file = "output/dates.json")
# TODO: automatically use top 5 commands
commands = c("git", "ls", "vim", "exit", "cd")
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
plot(Count ~ Date, commands.data, xaxt="n", type="n", main="Command Usage Over Time")
axis(1, commands.data$Date, format(commands.data$Date, "%b %d"), cex.axis = .7)

# Plot points
for (i in 1:length(commands)) {
    command = commands[i]
    color = colors[i]

    command.data = data.frame(unlist(dates[[command]]))
    command.data$Date = as.Date(rownames(command.data), "%Y-%m-%d")
    colnames(command.data) = c("Count", "Date")
    rownames(command.data) = c()
    command.data = command.data[order(command.data$Date),]
    points(command.data$Date, command.data$Count, type="o", col=color)
}
legend(x="topright", legend=commands, col=colors, lty=1, cex=0.8)

dev.print(png, "output/dates.png", width=800, height=500)

Sys.sleep(1000)
