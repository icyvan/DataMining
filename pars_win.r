euclideanDistance <- function(u, v)
{
  sqrt(sum((u - v)^2))
}

sortObjectsByDist <- function(xl, z, metricFunction = euclideanDistance)
{
  l <- dim(xl)[1]
  n <- dim(xl)[2] - 1
  
  distances <- matrix(NA, l, 2)
  
  for (i in 1:l)
  {
    distances[i, ] <- c(i, metricFunction(xl[i, 1:n], z))
  }
  
  #Создаём переменные, в которые вносятся названия и расстояния
  v2 <- distances[order(distances[,2], distances[,1]),]
  v1 <- xl[order(distances[, 2]), ]
  orderedXl <- cbind(v1,rast=v2[,2])
  orderedXl <- orderedXl[,3:4]
  return (orderedXl);
}

#прямоугольное окно
P <- function(rast, h) {
  if(abs(rast/h) <= 1){
    return (0.5)
  } else {
    return(0)
  }
}
#ядро епачникова
#E <-function(rast, h){
# if(abs(rast/h) <= 1){
#   return(3/4 * (1 - (rast/h)^2))
# } else {
#   return(0)
#  }
#}
#квадратное ядро
#K <-function(rast, h){
#  if(abs(rast/h) <= 1){
#    return(15/16 * (1 - (rast/h)^2)^2)
# } else {
#    return(0)
#  }
#}
#ядро треугольлника
#T <-function(rast, h){
#  if(abs(rast/h) <= 1){
#    return(1-abs(rast/h))
#  } else {
#    return(0)
#  }
#}
#ядро гауссовское
#G <- function(rast, h){
#  if(abs(rast/h) <= 1){
#    return ( (2*pi)^(-1/2) * exp(-1/2 * (rast/h)^2 ) )
#  } else {
#    return(0)
#  }
#}

pars_win <- function(xl, z, h) 
{ 
  orderedXl <- sortObjectsByDist(xl, z) 
  
  for(i in 1:150){
    orderedXl[i,3] <-  G(orderedXl[i,2],h) 
  }
  
  s1 <- c('setosa', 'versicolor', 'virginica')
  s2 <- c(0,0,0)
  
  s2[1]=sum(orderedXl[orderedXl$Species=='setosa', 3])
  s2[2]=sum(orderedXl[orderedXl$Species=='versicolor', 3])
  s2[3]=sum(orderedXl[orderedXl$Species=='virginica', 3])
  
  amo <- cbind(b1,b2) #объединяем столбцы b1 и b2
  
  if(amo[1,2]==0&&amo[2,2]==0&&amo[3,2]==0){  
    class <- 'white'
  }
  else{
    class <- s1[which.max(s2)]
  }
  return (class) 
}


colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1, xlab = "Длина лепестка", ylab = "Ширина лепестка", main = "Ядро прямоугольника")

h=0.3 #ширина окна
xl <- iris[, 3:5]
z <- c(5,1.4)
class <- pars_win(xl,z,h)
points(z[1], z[2], pch = 21, col = colors[class], asp = 1)

a=0.8
b=0

while(a<7){
  while(b<3){
    z <- c(a, b)
    class <- pars_win(xl, z, h)
    points(z[1], z[2], pch = 21, col = colors[class], asp = 1)
    b=b+0.1
  }
  b=0
  a=a+0.1
}
