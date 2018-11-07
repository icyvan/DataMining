colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")
plot(NULL, NULL, type = "l", xlim = c(min(iris[, 3]), max(iris[, 3])), ylim = c(min(iris[, 4]), max(iris[, 4])), xlab = 'Petal.Length', ylab = 'Petal.Width')

euclideanDistance <- function(u, v) {         # Евклидово расстояние          
  sqrt(sum((u - v)^2))
}

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
return (orderedXl);

kNN <- function(xl, z, k)               #Применеям метод kNN
{
  orderedXl <- sortObjectsByDist(xl, z) # Сортируем выборку согласно классифицируемого объекта
  n <- dim(orderedXl)[2] - 1
  classes <- orderedxl[1:k, n + 1]    # Получаем класс первых k соседей
  counts <- table(classes)            # Составляем таблицу встречаемости каждого класса
  classname <- which.max(counts)      # Находим класс, который доминирует среди первых k соседей
  return (class)
}                             


colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue") # Рисуем выборку
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)

z <- c(2.7, 1)                      # Классификация одного заданного объекта
xl <- iris[, 3:5]
class <- kNN(xl, z, k=6)
points(z[1], z[2], pch = 22, bg = colors[class], asp = 1)

legend("bottomright", c("virginica", "versicolor", "setosa"), pch = c(15,15,15), col = c("blue", "green3", "red"))
