data <- c(19, 33, 38, 31, 26, 25, 26, 25, 25, 21, 21, 19, 16)

barplot(data, main="Delivery\nDaily Usage Chart", 
        names.arg=c("J","J","A","S","O","N","D","J","F","M","A","M","J"),
        xlab="MONTHS", ylab="kWh Per Day")






data <- c(7.57, 7.57, 7.57, 7.57, 7.57, 7.57, 7.57, 7.57, 8.65, 8.65, 8.65, 8.65, 8.65)

barplot(data, main="Effective Generation Rate", 
        names.arg=c("J","J","A","S","O","N","D","J","F","M","A","M","J"),
        xlab="MONTHS", ylab="c / kWh", ylim=c(0, 10), yaxt="n")

axis(side=2, at=seq(0, 10, by=1))

