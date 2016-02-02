download_gapminder <- function(destination_filename) {
  url <- "https://raw.githubusercontent.com/dfalster/2016-02-01-ResBaz-reproducible/0cd5f9f8fd5c68f4e2c2087fcadc73d0954dc0e8/1-standard/data/gapminder-FiveYearData.csv"
  download(url, destination_filename, mode="wb")
}

fit_models <- function(data) {
  ddply(data, .(continent, year), fit.model, x="lifeExp", y="gdpPercap")
}

figure_1982 <- function(data) {
  data.1982 <- data[data$year == 1982,]
  myplot(data.1982,"gdpPercap","lifeExp", main =1982)
}

figure_year <- function(data, year) {
  data.sub <- data[data$year == year,]
  myplot(data.sub,"gdpPercap","lifeExp", main =year)
}


average  <-  function(x) {
    sum(x) / length(x)
}

rescale  <-  function(x, range) {
    p  <-  (x - min(x)) / (max(x) - min(x))
    range[[1]] + p * (range[[2]] - range[[1]])
}

colour.by.category <- function(things, table) {
    unname(table[things])
}

add.trend.line <- function(x, y, d, ...) {
  logx <- log10(d[[x]])
  logy <- log10(d[[y]])

  fit <- lm(logy ~ logx)
  xr <- range(logx)
  lines(10^xr, 10^predict(fit, list(logx=xr)), ...)
}

myplot <- function(data,x,y,...){

  col.table <- c(Asia="tomato", Europe="chocolate4", Africa="dodgerblue2", Americas="darkgoldenrod1", Oceania="green4")

  plot(data[[y]]~data[[x]], log="xy", pch=16, las=1,
       ylim = c(20, 100), xlim = c(200, 50000),
       cex=rescale(sqrt(data$pop), c(0.2, 10)),
       col=colour.by.category(data$continent, col.table),
       xlab=x, ylab=y,...)
  d_ply(data, .(continent), function(df) add.trend.line(x, y, df, col=col.table[df$continent]))
}

pop.by.country.relative <- function(country, data, base.year=1952) {
  dsub <- data[data$country == country, c("year", "pop")]
  dsub$pop.rel <- dsub$pop / dsub$pop[dsub$year == base.year]
  dsub
}

fit.model <- function(d, x, y) {
  fit <- lm( d[[y]] ~ log10(d[[x]]) )
  data.frame(n=length(d[[y]]), r2=summary(fit)$r.squared,a=coef(fit)[1],b=coef(fit)[2])
}
