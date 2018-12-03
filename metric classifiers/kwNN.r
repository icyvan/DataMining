colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")
plot(NULL, NULL, type = "l", xlim = c(min(iris[, 3]), max(iris[, 3])), ylim = c(min(iris[, 4]), max(iris[, 4])), xlab = 'Petal.Length', ylab = 'Petal.Width')

euclideanDistance <- function(u, v) {         # Евклидово расстояние          
  sqrt(sum((u - v)^2))
}

k <- 6
q <- 0.5 # for check

sortObjectsByDist <- function(xl, z, metricFunction = euclideanDistance) # Сортируем объекты согласно 
{                                                                        # расстояния до объекта z
  l <- dim(xl)[1] # 150
  n <- dim(xl)[2] - 1 # 2
}


distances <- matrix(NA, l, 2)             # матрица расстояний
for(p in 1:l) {
  distances[p, ] <- c(p, euclideanDistance(xl[p, 1:n], point))
}
orderedxl <- xl[order(distances[ , 2]), ] # сортируем расстояния

weights <- c(NA)
for(t in 1:l) {
  weights[t] <- q^t
}
orderedxl_weighted <- cbind(orderedxl, weights)
classes <- orderedxl_weighted[1:k, (n + 1):(n + 2)] # number, name of class and weight
sumSetosa <- sum(classes[classes$Species == "setosa", 2])
sumVersicolor <- sum(classes[classes$Species == "versicolor", 2])
sumVirginica <- sum(classes[classes$Species == "virginica", 2])
answer <- matrix(c(sumSetosa, sumVersicolor, sumVirginica), 
                 nrow = 1, ncol = 3, byrow = T, list(c(1), c('setosa', 'versicolor', 'virginica')))
points(point[1], point[2],  pch = 21, bg = "white", col = colors[which.max(answer)])

colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue") # Рисуем выборку
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)

z <- c(2.7, 1)                      # Классификация одного заданного объекта
xl <- iris[, 3:5]
class <- kNN(xl, z, k=6)
points(z[1], z[2], pch = 22, bg = colors[class], asp = 1)

legend("bottomright", c("virginica", "versicolor", "setosa"), pch = c(15,15,15), col = c("blue", "green3", "red"))
