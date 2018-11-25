## Навигация
* [Метрические алгоритмы классификации](#метрические-алгоритмы-классификации)
   * [Алгоритм ближайшего соседа (1NN)](#алгоритм-ближайшего-соседа-1nn)
      * [Алгоритм k ближайших соседей (kNN)](#алгоритм-k-ближайших-соседей-knn)
      * [Алгоритм k взвешенных ближайших соседей (kwNN)](#алгоритм-k-взвешенных-ближайших-соседей-kwnn)
      * [Метод парзеновского окна](#метод-парзеновского-окна)
      * [Метод потенциальных функций](#метод-потенциальных-функций)

# Метрические алгоритмы классификации

**Метрический алгоритм** - алгоритм классификации основанный на оценке близости объектов, используя функцию расстояния. 

При этом метрические алгоритмы основываются на гипотезе компактности, которая говорит, что схожим объектам соответствуют схожие ответы.

Метрические методы обучения - методы, основанные на анализе сходства объектов.

 Метрический алгоритм классификации с обучающей выборкой ![](https://latex.codecogs.com/gif.latex?X^l)  относит объект u к тому классу y, для которого суммарный вес ближайших обучающих объектов ![](https://latex.codecogs.com/gif.latex?W_y(u,X^l)) максимален:
 
![](https://latex.codecogs.com/gif.latex?a(u;X^l)=arg&space;\max_{y\epsilon&space;Y}W_y(u,X^l)),
где весовая функция ![](https://latex.codecogs.com/gif.latex?\omega&space;(i,u)) оценивает степерь важности i-го соседа классификации объекта u.

Функция ![](https://latex.codecogs.com/gif.latex?W_y(u,X^l)) - наз оценкой близости *u* к классу *y*.

Алгоритм ближайшего соседа (1NN)
---------------- 
**Алгоритм ближайшего соседа - 1NN** относит классифицируемый объект ![](https://latex.codecogs.com/gif.latex?u\epsilon&space;X^l) к тому классу, которому принадлежит его ближайший сосед.

Результат реализованного [1NN](https://github.com/icyvan/DataMining/blob/master/1NN.R):

![](https://github.com/icyvan/DataMining/blob/master/images/1NN_1.png)

Алгоритм k ближайших соседей (kNN)
---------------- 
 
**Алгоритм k ближайших соседей - kNN** отоносит объект *u* к тому классу элементов, которого больше среди k ближайших соседей ![](https://latex.codecogs.com/gif.latex?x_u).

Мы используем выборку Ирисов Фишера (iris), содержащий 150 объектов разделенный на три класса по 50 элементов: setosa , versicolour и virginica. Каждый класс представлен четырьмя признаками: «Sepal.Length» (длина чашелистика), «Sepal.Width» (ширина чашелистика), «Petal.Length» (длина лепестка) и «Petal.Width» (ширина лепестка).


**Алгоритм выглядит следующим образом:**

1. Вычисляем евклидово расстояние от классфицируемого объекта до элементов выборки.

```diff
euclideanDistance <- function(u, v) {
  sqrt(sum((u - v)^2)) }
```

2. Сортируем расстояния в порядке возрастания и выбираем первые k элементов.
```diff
sortObjectsByDist <- function(xl, z, metricFunction = euclideanDistance) {       # Сортируем объекты согласно 
 l <- dim(xl)[1]                                                                 # расстояния до объекта z
 n <- dim(xl)[2] - 1
 
 distances <- matrix(NA, l, 2)                                                   # Создаём матрицу расстояний
 for (i in 1:l)  {
 distances[i, ] <- c(i, metricFunction(xl[i, 1:n], z))
 }
 orderedXl <- xl[order(distances[, 2]), ]                                        # Сортируем
 return (orderedXl);
```

3. Выбираем наиболее часто встречающийся класс среди k ближайших соседей.

```diff
kNN <- function(xl, z, k)  { 
 orderedXl <- sortObjectsByDist(xl, z)      # Сортируем выборку согласно классифицируемого объекта
 n <- dim(orderedXl)[2] - 1
 classes <- orderedXl[1:k, n + 1]           # Получаем классы первых k соседей
 counts <- table(classes)                   # Составляем таблицу встречаемости каждого класса
 class <- names(which.max(counts))          # Находим класс, который доминирует среди первых k соседей
 return (class)
}
```
Результат реализацмм [kNN](https://github.com/icyvan/DataMining/blob/master/kNN.R):

![](https://github.com/icyvan/DataMining/blob/master/images/kNN2.png)

**Оптимизация k**

Оптимальное значение параметра k определяют по критерию скользящего контроля с исключением объектов по одному (leave-one-out, LOO). Для каждого объекта ![](https://latex.codecogs.com/gif.latex?x_i&space;\epsilon&space;X^l) проверяется, равильно ли он классифицируется по своим *k* ближайшим соседям.

![](https://latex.codecogs.com/gif.latex?LOO(\mu&space;,&space;X^l)&space;=&space;1/l&space;\sum_{i=1}^{l}&space;Q&space;(\mu&space;(X^l/{x_i}),&space;{x_i}))

Идея LOO состоит в том, что мы их выборки убираем один объект, обучаем нашу выборку без этого объекта, а потом обучаем этот объект. Таким образом перебирая все элементы выборки, мы найдем оптимальное k.

ПреимуществаLOO в том, что каждый объект ровно один раз участвует в контроле,а длина обучающих подвыборок лишь на единицу меньше длины полной выборки.

Недостатком LOO является большая ресурсоёмкость, так как обучаться приходится L раз.

Ниже представлены график зависимости [LOO](https://github.com/icyvan/DataMining/blob/master/kNN_LOO.r) от kNN и карта классификафии всех объектов:

![](https://github.com/icyvan/DataMining/blob/master/images/loo_knn.png)

k оптимальное равняется 6.

Алгоритм k взвешенных ближайших соседей (kwNN)
--------------
kwNN отличается от kNN тем, что для оценки близости используется весовая функция:

![](https://latex.codecogs.com/gif.latex?W(i,u)&space;=&space;[i\leq&space;k]&space;w(i))
, где *i* - порядок соседа по расстоянию к классифицируемому объекту *u*, а *w(i)* - весовая функция.

Возьмем за вес ![](https://latex.codecogs.com/gif.latex?w(i)=q^i,&space;q\epsilon&space;(0,1)).

Реализация весовой функции:

```diff
  m <- c("setosa" = 0, "versicolor" = 0, "virginica" = 0)   # Устанавливаем начальные веса
  for (i in seq(1:k)){                                      # Запускаем цикл по упорядоченной посл-ти 
    w <- q ^ i                                              # Реализуем весовую функцию
    m[[classes[i]]] <- m[[classes[i]]] + w                  
  }
 class <- names(which.max(m))                               # Возвращаем класс с самым большим весом
  return (class)
}
```
Ниже представлены график зависимости [LOO от kwNN](https://github.com/icyvan/DataMining/blob/master/LOO_kwNN.r) и карта классификафии всех объектов:

![](https://github.com/icyvan/DataMining/blob/master/images/kwNN.png)

Лучший результат при k = 6 и q = 1 равен 0.33.

Метод парзеновского окна
-----------
В этом методе мы рассматриваем весовую функцию ![](https://latex.codecogs.com/gif.latex?w(i,u)), как функцию зависящую от расстояния ![](https://latex.codecogs.com/gif.latex?\rho&space;(u,x_{(i))}^{u}) :
![](https://latex.codecogs.com/gif.latex?w(i,u)=K((1/h)\rho(u,x_{u}^{(i)}))), где *K*-функция ядра(окна).

Парзеновская оценка плотности имеет вид:

![](https://latex.codecogs.com/gif.latex?a(x;X^{l},h)=arg\max_{y\epsilon&space;Y}\lambda&space;_{y}\sum_{i:y_{i}=y}&space;K(\frac{\rho(x,x_{i})}{h}))

Ядро выбирается из нижеприведенного набора ядер:

| № | ядро K(r)     | Формула                                                                                                                                                                                             |
|---|---------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1 | Епанечникова  | ![](https://latex.codecogs.com/gif.latex?E(r)=&space;\frac{3}{4}(1-r^{2})\left&space;[&space;r\leq&space;1&space;\right&space;])|
| 2 | Квартическое  | ![](https://latex.codecogs.com/gif.latex?Q(r)=&space;\frac{15}{16}(1-r^{2})^{2}\left&space;[&space;r\leq&space;1&space;\right&space;])|
| 3 | Треугольное   | ![](https://latex.codecogs.com/gif.latex?T(r)=(1-r)&space;\left&space;[&space;r\leq&space;1&space;\right&space;])|
| 4 | Гауссовское   | ![](https://latex.codecogs.com/gif.latex?G(r)=(2\pi&space;)^{-\frac{1}{2}}e^{-\frac{1}{2}r^{2}})|
| 5 | Прямоугольное | ![](https://latex.codecogs.com/gif.latex?\Pi&space;(r)=\frac{1}{2}\left&space;[&space;r\leq&space;1\right&space;])|

Метод	потенциальных	функций
-----------
