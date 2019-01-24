<<<<<<< HEAD
library(MASS)
estimateMu = function(points) {
  rows = dim(points)[1]
  cols = dim(points)[2]
  mu = matrix(NA, 1, cols)
  for (col in 1:cols) {
    mu[1, col] = mean(points[, col])
  }
  return(mu)
=======
data(iris)
x <- cbind(iris$Petal.Length,iris$Petal.Width)
Y <- ifelse(iris$Species == "virginica", +1, -1)

u <- apply(x,2,mean)

up <- apply(subset(x,Y==+1), 2, mean)
un <- apply(subset(x,Y==-1), 2, mean)
np <- sum(Y==+1)
nn <- sum(Y==-1)

t <- seq(- pi , pi, 0.05)

uv <- cbind(cos(t), sin(t))

SB <- nn * (un - u) %*% t(up - u)

scatter <- function(v){
  ((v - un) %*% t(v - un)) + ((v - up) %*% t(v - up))
>>>>>>> ccd580f0dffe6ada43efc3eef7eab97f930d50d9
}
estimateFisherCovarianceMatrix <- function(objects1, objects2, mu1, mu2)
{
  rows1 <- dim(objects1)[1]
  rows2 <- dim(objects2)[1]
  rows <- rows1 + rows2
  cols <- dim(objects1)[2]
  sigma <- matrix(0, cols, cols)
  for (i in 1:rows1)
  {
    sigma <- sigma + (t(objects1[i,] - mu1) %*% (objects1[i,] - mu1)) / (rows + 2)
  }
  for (i in 1:rows2)
  {
    sigma <- sigma + (t(objects2[i,] - mu2) %*% (objects2[i,] - mu2)) / (rows + 2)
  }
  return (sigma)
}
<<<<<<< HEAD
## Генерируем тестовые данные
Sigma1 <- matrix(c(5, 0, 0, 1), 2, 2)
Sigma2 <- matrix(c(5, 0, 0, 1), 2, 2)
Mu1 <- c(1, 0)
Mu2 <- c(10, 0)
xy1 <- mvrnorm(n=ObjectsCountOfEachClass, Mu1, Sigma1)
xy2 <- mvrnorm(n=ObjectsCountOfEachClass, Mu2, Sigma2)
## Собираем два класса в одну выборку
xl <- rbind(cbind(xy1, 1), cbind(xy2, 2))
## Рисуем обучающую выборку
colors <- c("yellow", "violet")
plot(xl[,1], xl[,2], pch = 21, bg = colors[xl[,3]], asp = 1)
## Оценивание
objectsOfFirstClass <- xl[xl[,3] == 1, 1:2]
objectsOfSecondClass <- xl[xl[,3] == 2, 1:2]

mu1 <- estimateMu(objectsOfFirstClass)
mu2 <- estimateMu(objectsOfSecondClass)
Sigma <- estimateFisherCovarianceMatrix(objectsOfFirstClass, objectsOfSecondClass, mu1, mu2)
## Получаем коэффициенты ЛДФ
inverseSigma <- solve(Sigma)
alpha <- inverseSigma %*% t(mu1 - mu2)
mu_st <- (mu1 + mu2) / 2
beta <- mu_st %*% alpha
## Рисуем ЛДФ
abline(beta / alpha[2,1], -alpha[1,1]/alpha[2,1], col = "red", lwd = 3)
=======

ratios <- apply(uv, 1, action, SB) / apply(uv, 1, action, SW)

mr <- which.max(ratios)
muv <- uv[mr,]
mv <- 40*ratios[mr]*muv
xp <- as.vector(x %*% muv)
rxp <- round(range(xp),0)+c(-1,1)
xpn <- subset(xp,Y==-1)
xpp <- subset(xp,Y==+1)
b = (mean(xpp) * sd(xpn) + mean(xpn) * sd(xpp)) /(sd(xpp) + sd(xpn))
plot(x,col=Y+3,asp=1, xlab = "Sepal.Length", ylab = "Sepal.Width", main = paste("Г‹ГЁГ­ГҐГ©Г­Г»Г© Г¤ГЁГ±ГЄГ°ГЁГ¬ГЁГ­Г Г­ГІ Г”ГЁГёГҐГ°Г "))
par(lwd=2)
abline(b/muv[2],-muv[1]/muv[2])
distance.from.plane = function(x,w,b) {
  b - sum(x*w)
}
classify.fisher = function(x,w,b) {
  distances = apply(x, 1, distance.from.plane, w, b)
  return(ifelse(distances < 0, -1, +1))
}

sum(abs(Y - classify.fisher(x,muv,b) ))
>>>>>>> ccd580f0dffe6ada43efc3eef7eab97f930d50d9
