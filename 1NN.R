colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species])

euclideanDistance <- function(u, v) {
  sqrt(sum((u - v)^2))
}

xl <- iris[, 3:5]
l <- dim(xl)[1] # 150 
n <- dim(xl)[2] - 1 # 2

X <- seq(from = min(iris[, 3]), to = max(iris[, 3]), by = 0.1) # Petal.Length
Y <- seq(from = min(iris[, 4]), to = max(iris[, 4]), by = 0.1) # Petal.Width

distances <- matrix(NA, l, n) # матрица расстояний

for(i in X) {
  for(j in Y) {
    point <- c(i, j)
    for(k in 1:l){
      distances[k, ] <- c(k, euclideanDistance(xl[k, 1:n], point))
    }
    orderedxl <- xl[order(distances[ , 2]), ] # сортировка расстояний
    points(point[1], point[2], pch = 21, bg = "white", col = colors[orderedxl$Species[1]])
  }
}