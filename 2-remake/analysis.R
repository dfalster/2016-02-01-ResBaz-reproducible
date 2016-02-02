
library(plyr)
source("R/functions.R")
data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)



###### SAVING TABLES############

# For each year, fit linear model to life expectancy vs gdp by continent
model.data <- ddply(data, .(continent, year), fit.model, x="lifeExp", y="gdpPercap")

# save to file
dir.create("output/figures", recursive=TRUE)
write.csv(model.data, file="output/table1.csv")

####SAVING PLOTS############
data.1982 <- data[data$year == 1982,]
myplot(data.1982,"gdpPercap","lifeExp", main =1982)

# one way of saving to pdf
pdf("output/figures/1982-a.pdf", width=6, height=4)
  myplot(data.1982,"gdpPercap","lifeExp", main =1982)
dev.off()

# a better way of saving to pdf
to.pdf(
  myplot(data.1982,"gdpPercap","lifeExp", main =1982)
  , "output/figures/1982-b.pdf", width=6, height=4)


# similar approach to save png
to.png(
  myplot(data.1982,"gdpPercap","lifeExp", main =1982)
  , "output/figures/1982.png", width=800, height=600)


# do for all years
f <- function(x) {
  year <- x$year[1]
  to.pdf(
    myplot(x,"gdpPercap","lifeExp", main = year)
  , paste0("output/figures/",year,".pdf")
  , width=6, height=4)
}

d_ply(data, "year", f)
