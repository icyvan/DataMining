colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species])

euclideanDistance <- function(u, v) {
  sqrt(sum((u - v)^2))
}

sort <- function(xl, point, euclideanDistance)
{
  l <- dim(xl)[1]
  n <- dim(xl)[2] - 1
}

PentalWedth <- seq(from = min(iris[ , 3]), to = max(iris[ , 3]), by = 0.1) #все строки в столбце
PentalLength <- seq(from = min(iris[ , 4]), to = max(iris[ , 4]), by = 0.1)

for (i in PentalWedth)
  for (j in PentalLength)
    point <- c(i,j)
distances <- matrix(NA, l, 2)
for (k in 1:l)
{
  distances[k, ] <- c(k, euclideanDistance(xl[k, 1:n], point))
}
 orderedxl <- xl[order(euclideanDistance[ , 2], )] #сортировка расстояния
  classes <- orderedxl[1:k, n+1] #имена первых k классов из orderedxl
  count <- table(classes)  #table-возвращает таблицу с чaстотами встречаемости каждого значения classes
  
  
