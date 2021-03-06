## Оглавление 
* [Метрические алгоритмы классификации](#метрические-алгоритмы-классификации)
   * [Алгоритм ближайшего соседа (1NN)](#алгоритм-ближайшего-соседа-1nn)
   * [Алгоритм k ближайших соседей (kNN)](#алгоритм-k-ближайших-соседей-knn)
   * [Алгоритм k взвешенных ближайших соседей (kwNN)](#алгоритм-k-взвешенных-ближайших-соседей-kwnn)
   * [Метод парзеновского окна](#метод-парзеновского-окна)
   * [Сравнительная таблица](#сравнительная-таблица)
* [Байесовские алгоритмы классификации](#байесовские-алгоритмы-классификации)   
   * [Линии уровня нормального распределения](#линии-уровня-нормального-распределения)
   * [Наивный нормальный байесовский классификатор](#наивный-нормальный-байесовский-классификатор)
   * [Постановочный алгоритм](#постановочный-алгоритм)
   * [Линейный дискриминант Фишера](#линейный-дискриминант-Фишера)
* [Линейные алгоритмы классификации](#линейные-алгоритмы-классификации)   
   * [Метод стохастического градиента](#метод-стохастического-градиента)
   * [ADALINE](#adaline)
   * [Персептрон Розенблатта](#персептрон-розенблатта)
   * [Логистическая регрессия](#логистическая-регрессия)
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

Результат реализованного [1NN](https://github.com/icyvan/DataMining/blob/master/metric%20classifiers/1NN.R):

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
Результат реализацмм [kNN](https://github.com/icyvan/DataMining/blob/master/metric%20classifiers/kNN.R):

![](https://github.com/icyvan/DataMining/blob/master/images/kNN2.png)

**Оптимизация k**

Оптимальное значение параметра k определяют по критерию скользящего контроля с исключением объектов по одному (leave-one-out, LOO). Для каждого объекта ![](https://latex.codecogs.com/gif.latex?x_i&space;\epsilon&space;X^l) проверяется, равильно ли он классифицируется по своим *k* ближайшим соседям.

![](https://latex.codecogs.com/gif.latex?LOO(\mu&space;,&space;X^l)&space;=&space;1/l&space;\sum_{i=1}^{l}&space;Q&space;(\mu&space;(X^l/{x_i}),&space;{x_i}))

Идея LOO состоит в том, что мы их выборки убираем один объект, обучаем нашу выборку без этого объекта, а потом обучаем этот объект. Таким образом перебирая все элементы выборки, мы найдем оптимальное k.

ПреимуществаLOO в том, что каждый объект ровно один раз участвует в контроле,а длина обучающих подвыборок лишь на единицу меньше длины полной выборки.

Недостатком LOO является большая ресурсоёмкость, так как обучаться приходится L раз.

Ниже представлены график зависимости [LOO](https://github.com/icyvan/DataMining/blob/master/metric%20classifiers/kNN_LOO.r) от kNN и карта классификафии всех объектов:

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
Ниже представлены график зависимости [LOO от kwNN](https://github.com/icyvan/DataMining/blob/master/metric%20classifiers/LOO_kwNN.r) и карта классификафии всех объектов:

![](https://github.com/icyvan/DataMining/blob/master/images/kwNN.png)

Лучший результат при k = 6 и q = 1 равен 0.33.

Метод парзеновского окна
-----------
В этом методе мы рассматриваем весовую функцию ![](https://latex.codecogs.com/gif.latex?w(i,u)), как функцию зависящую от расстояния ![](https://latex.codecogs.com/gif.latex?\rho&space;(u,x^{u}_{(i)})) :
![](https://latex.codecogs.com/gif.latex?w(i,u)=K((1/h)\rho(u,x_{u}^{(i)}))), где *K*-функция ядра (окна).

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

В этом алгоритме для классифицируемой точки строится окружность(окна). Точки не попавшие в эту окружность, с заданной шириной h, отсеиваются, а попавшим присваивается вес и суммируется их колличество. Так, классифицируемая точка присваивается классу с наибольшим весом.

Реализация алгоритма [pars_win](https://github.com/icyvan/DataMining/blob/master/metric%20classifiers/pars_win.r):
```diff
pars_win <- function(xl, z, h)               #в функцию заносим выборку, точку и ширину окна
{ 
  orderedXl <- sortObjectsByDist(xl, z)      #сортируем выборку согласно классифицируемого объекта
  
  for(i in 1:150){                           #запускаем цикл
    orderedXl[i,3] <-  T(orderedXl[i,2],h)   #применяем функцию ядра 
  }
  
  w1 <- c('setosa', 'versicolor', 'virginica')
  w2 <- c(0,0,0)                        
  
  #суммируем по классам
  w2[1]=sum(orderedXl[orderedXl$Species=='setosa', 3])
  w2[2]=sum(orderedXl[orderedXl$Species=='versicolor', 3])
  w2[3]=sum(orderedXl[orderedXl$Species=='virginica', 3])
  
  union <- cbind(w1,w2)                            #объединяем столбцы
  
  if(union[1,2]==0&&union[2,2]==0&&union[3,2]==0){ #если веса классов равны 0, то
    class <- 'white'                               #класс становится белым
  }
  else{
    class <- w1[which.max(w2)]                     #иначе возвращается класс с максимальным весом
  }
  return (class) 
}
```
Ниже представвлены карты классификации для всех функций ядер:

![](https://github.com/icyvan/DataMining/blob/master/images/E.png)
![](https://github.com/icyvan/DataMining/blob/master/images/K.png)
![](https://github.com/icyvan/DataMining/blob/master/images/P.png)
![](https://github.com/icyvan/DataMining/blob/master/images/T.png)
![](https://github.com/icyvan/DataMining/blob/master/images/G.png)

На картинках видно, что Гауссовское ядро имеет преимущество, так как классифицирует все точки. В остальных ядрах, точки не попавшие в окна не классифицируются.

*Достоинства алгоритма:*

* Простота реализации

* Высокое качество классификации при правильно подобранном h

* Сортировка выборки не требуется, что соеращает время

*Недостатки алгоритма:*

* Необходимость хранить выборку целиком

* Малый набор параметров

* Если объект не попал в ширину h, то объект не классифицируется, за исключением Гауссовского.

Сравнительная таблица
------------------

| Алгоритм                              | Параметры | LOO   |
|---------------------------------------|-----------|-------|
| kNN                                   | k=6       | 0,033 |
| kwNN                                  | k=6       | 0,033 |
| Парзеновские окна: ядро Епанечникова  | h=   |  |
| Парзеновские окна: ядро Квартическое  | h=   |  |
| Парзеновские окна: ядро Треугольное   | h=   |  |
| Парзеновские окна: ядро Гауссовское   | h=   |  |
| Парзеновские окна: ядро Прямоугольное | h=   |  |

Байесовские алгоритмы классификации
--------

Теперь,в байесовских алгоритмах классификации, пространство ![](https://latex.codecogs.com/gif.latex?X\times&space;Y)  является веротностным, его плотность неизвестна ![](https://latex.codecogs.com/gif.latex?p(x,y)=P(y)p(x|y)=P(y|x)p(x)).

Вероятности появления объектов каждого из классов ![](https://latex.codecogs.com/gif.latex?P_{y}=P(y)) называется априорными вероятностями классов(вероятность, которую мы проводим теоритически).

Условная вероятность ![](https://latex.codecogs.com/gif.latex?P(y|x)) наз апостериорной вероятностью классов *y* для объекта *x*(вероятность, после получения результата).

Плотности распределения ![](https://latex.codecogs.com/gif.latex?p_{y}=p(x|y)) называются функциями правдоподобия классов.


Линии уровня нормального распределения
-----------
 Если признаки некоррелированы, ![](http://latex.codecogs.com/svg.latex?%5CSigma%20%3D%20%5Cmbox%7Bdiag%7D%28%5Csigma_1%5E2%2C...%2C%5Csigma_n%5E2%29), то линии уровня плотности распределения имеют
форму эллипсоидов с центром *µ* и осями, параллельными линиям координат.

Если признаки имеют одинаковые дисперсии, ![](http://latex.codecogs.com/svg.latex?%5CSigma%20%3D%20%5Csigma%5E2I_n) , то эллипсоиды являются сферами.

Если признаки коррелированы, то матрица ![](https://latex.codecogs.com/gif.latex?\sum) не диагональна и линии уровня имеют форму эллипсоидов, оси которых повёрнуты относительно исходной системы координат.

![](https://github.com/icyvan/DataMining/blob/master/images/lines.png)



Наивный нормальный байесовский классификатор
--------
Если мы занулим все недиагональные элементы матрицы, посчитаем по всем признаками дисперсии, то что получается классификатор, который называется наивным.

Мы предполагаем, что все признаки независимы и получаем, что плотности должны выглядеть таким образом:
![](https://latex.codecogs.com/gif.latex?\hat{p}_{yj}(\xi)=\frac{1}{\sqrt{2\pi}\hat{\sigma_{yj}}}exp(-\frac{(\xi-\hat{\mu_{yj}})^{2}}{2\hat{\sigma}^{2}_{yj}}),&space;y&space;\epsilon&space;Y&space;,j=1,...,n)

По каждому признаку отдельно в каждом классе высчитаем матожидание и дисперсию и подставив в плотность получим:

![](https://latex.codecogs.com/gif.latex?a(x)=arg&space;\max_{y\epsilon&space;Y}(ln\lambda&space;_{y}\hat{P}_{y}&space;&plus;\sum_{j=1}^{n}ln\hat{p}_{yj}(\xi&space;_{j})),&space;x=(\xi&space;_{1},...,\xi&space;_{n});)

где ![](https://latex.codecogs.com/gif.latex?\hat{\mu}_{yj}) и ![](https://latex.codecogs.com/gif.latex?\hat{\sigma}_{yj}) - оценки матожидания и дисперсии *j*-го признака, вычисленные по ![](https://latex.codecogs.com/gif.latex?X_{y}) - подвыборке класса *y*.

Результат классификации классов, имеющих разные матрицы ковариации и карта классификации всех объектов:
![](https://github.com/icyvan/DataMining/blob/master/images/naive_all.png) 

Постановочный алгоритм
--------
Если мы оценим параметры функции правдоподобия ![](https://latex.codecogs.com/gif.latex?\hat{\mu}_{y}) и ![](https://latex.codecogs.com/gif.latex?\hat{\Sigma&space;}_{y}) по частям обучающей выборки ![](https://latex.codecogs.com/gif.latex?X^{l}_{y}) для каждого класса ![](https://latex.codecogs.com/gif.latex?y\in&space;Y), а затем эти выборочные оценки подставим в оптимальный байесовский классификатор, то получим подстановочный алгоритм **plug-in**. Это байесовский нормальный классификатор оценки параметров гауссовской плотности, которого имеют вид: 

![](https://latex.codecogs.com/gif.latex?\hat{\mu}=\frac{1}{m}\sum_{i=1}^{m}x_{i};\hat{\Sigma}=\frac{1}{m}\sum_{i=1}^{m}(x_{i}-\hat{\mu&space;})(x_{i}-\hat{\mu&space;})^{T})

Cлучай, когда разделяющая кривая является **эллипсом**.

Первый класс: ![](https://latex.codecogs.com/gif.latex?\Sigma&space;=\begin{pmatrix}&space;3&space;&&space;0\\&space;0&&space;2&space;\end{pmatrix}) и ![](https://latex.codecogs.com/gif.latex?\mu&space;=&space;(15,2))

Второй класс: ![](https://latex.codecogs.com/gif.latex?\Sigma&space;=&space;\begin{pmatrix}&space;23&space;&0&space;\\&space;0&space;&&space;5&space;\end{pmatrix}) и ![](https://latex.codecogs.com/gif.latex?\mu&space;=&space;(25,2))

![](https://github.com/icyvan/DataMining/blob/master/images/plug-in.png)

Cлучай, когда разделяющая кривая является **парабола**.

Первый класс: ![](https://latex.codecogs.com/gif.latex?\Sigma&space;=\begin{pmatrix}&space;10&space;&&space;0\\&space;0&&space;1&space;\end{pmatrix}) и ![](https://latex.codecogs.com/gif.latex?\mu&space;=&space;(-1,0))

Второй класс: ![](https://latex.codecogs.com/gif.latex?\Sigma&space;=&space;\begin{pmatrix}&space;1&space;&0&space;\\&space;0&space;&&space;5&space;\end{pmatrix}) и ![](https://latex.codecogs.com/gif.latex?\mu&space;=&space;(3,0))

![](https://github.com/icyvan/DataMining/blob/master/images/plag-in2.png)

Cлучай, когда разделяющая кривая является **гипербола**.

Первый класс: ![](https://latex.codecogs.com/gif.latex?\Sigma&space;=\begin{pmatrix}&space;5&space;&&space;0\\&space;0&&space;1&space;\end{pmatrix}) и ![](https://latex.codecogs.com/gif.latex?\mu&space;=&space;(-1,0))

Второй класс: ![](https://latex.codecogs.com/gif.latex?\Sigma&space;=&space;\begin{pmatrix}&space;1&space;&0&space;\\&space;0&space;&&space;2&space;\end{pmatrix}) и ![](https://latex.codecogs.com/gif.latex?\mu&space;=&space;(3,0))

![](https://github.com/icyvan/DataMining/blob/master/images/plug-in3.png)


Линейный дискриминант Фишера
--------
Если предположить, что в алгоритме plug-in ковариационные матрицы классов одинаковые, тогда поверхность разделяющая между классами будет линейна и таким образом мы получаем линейгый дичкриминант Фишера. Остается подставить общую ковариационную матрицу классов в формулу байесовского классификатора:
![](https://latex.codecogs.com/gif.latex?\hat{\sum&space;}=\frac{1}{G}\sum_{i=1}^{l}g_{i}(x_{i}-\hat{\mu}_{y_{i}})(x_{i}-\hat{\mu}_{y_{i}})^{T},&space;G=\sum_{i=1}^{l}g_{i}). 

Демонстрация	работы	алгоритма при:

Первый класс: ![](https://latex.codecogs.com/gif.latex?\Sigma&space;=\begin{pmatrix}&space;5&space;&&space;0\\&space;0&&space;1&space;\end{pmatrix}) и ![](https://latex.codecogs.com/gif.latex?\mu&space;=&space;(5,1))

Второй класс: ![](https://latex.codecogs.com/gif.latex?\Sigma&space;=&space;\begin{pmatrix}&space;5&space;&0&space;\\&space;0&space;&&space;1&space;\end{pmatrix}) и ![](https://latex.codecogs.com/gif.latex?\mu&space;=&space;(15,0)) 

![](https://github.com/icyvan/DataMining/blob/master/images/ldf.png)

**Преимущества	линейного дискриминанта Фишера по	сравнению	с	подстановочным	алгоритмом** в том, что алгоритм значительно проще, в случае с двумя классами разделяющей поверхностью будет прямая, если классов более двух - кусочно-линейная поверхность. В постановочном алгоритме, если матрица плохо обусловлена, то появляется проблема мультиколлинеарности, в ЛДФ эффект плохой обусловленности  ковариационной матрицы уменьшается, при недостаточных данных. Ещё одним преимуществом является повышение устойчивости алгоритма.

Линейные алгоритмы классификации
-------
Пусть ![](https://latex.codecogs.com/gif.latex?X=\mathbb{R}^{n}) и ![](https://latex.codecogs.com/gif.latex?Y=\left&space;\{&space;-1,&plus;1&space;\right&space;\}), ![](https://latex.codecogs.com/gif.latex?X^{l}=(x_{i},y_{i})^{l}_{i=1})-обучающая выборка .

![](https://latex.codecogs.com/gif.latex?a(x,w)=sign&space;f(x,w)) - алгоритм классификации, где 

![](https://latex.codecogs.com/gif.latex?f(x,w)) - разделяющая (дискриминантная) поверхность;

![](https://latex.codecogs.com/gif.latex?w) - вектор параметров.

Уравнение ![](https://latex.codecogs.com/gif.latex?f(x,w)=0) - разделяющая поверхность.

Величина ![](https://latex.codecogs.com/gif.latex?M_{i}(w)=y_{i}\left&space;\langle&space;x_{i},w&space;\right&space;\rangle) называется отступом объекта относительно алгоритма классификации. Если ![](https://latex.codecogs.com/gif.latex?M_{i}(w)<&space;0), тогда алгоритм ![](https://latex.codecogs.com/gif.latex?a(x,w)) ошибается на ![](https://latex.codecogs.com/gif.latex?x_{i}).

Минимизация эмпирического риска

![](https://latex.codecogs.com/gif.latex?Q(w)=\sum_{i=1}^{l}[M_{i}(w)<&space;0]\leqslant&space;Q{}'(w)=\sum_{i=1}^{l}L(M_{i}(w))\rightarrow&space;\min_{w}),

где функция потерь ![](https://latex.codecogs.com/gif.latex?L(M)) невозрастающая, неотрицательная, происходит путём подбора оптимального вектора весов *w*, а для этого мы будем пользоваться методом стохастического градиента.

Метод стохастического градиента
----
Сначала выбираем начальное приближение ![](https://latex.codecogs.com/gif.latex?w^{(0)}). Далее высчитывается текущая оценка функционала ![](https://latex.codecogs.com/gif.latex?Q(w;X^{l})=\sum_{i=1}^{l}L(\left&space;\langle&space;w,x_{i}&space;\right&space;\rangle&space;y_{i})).

Затем запускается итерационный процесс ![](https://latex.codecogs.com/gif.latex?w^{(t&plus;1)}=w^{(t)}-\eta&space;\bigtriangledown&space;Q(w^{(t)}),&space;\bigtriangledown&space;Q(w)=\left&space;(&space;\frac{\partial&space;Q(w)}{\partial&space;w_{j}}&space;\right&space;)^{n}_{j=1}),  где ![](https://latex.codecogs.com/gif.latex?\eta) - градиентный шаг, так же называемый темпом обучения.
Или ![](https://latex.codecogs.com/gif.latex?w^{(t&plus;1)}=w^{(t)}-\eta\sum_{i=1}^{l}L{}'((w^{(t)},x_{i})y_{i})x_{i}y_{i})

**Aлгоритм:**

**Вход: выборка** ![](https://latex.codecogs.com/gif.latex?X^{l}); темп обучения ![](https://latex.codecogs.com/gif.latex?\eta); параметр ![](https://latex.codecogs.com/gif.latex?\lambda)

**Выход:** веса ![](https://latex.codecogs.com/gif.latex?w_{0},w_{1},...,w_{n};)

1: инициализировать  веса ![](https://latex.codecogs.com/gif.latex?w_{j},&space;j=0,...,n.)

2: инициализировать текущую оценку функционала:
![](https://latex.codecogs.com/gif.latex?Q=\sum_{i=1}^{l}L(\left&space;\langle&space;w,x_{i}&space;\right&space;\rangle&space;y_{i}))

3: **повторять**

4: выбрать объект ![](https://latex.codecogs.com/gif.latex?x_{i}) из ![](https://latex.codecogs.com/gif.latex?X^{l}) (например, случайно)

5: вычислить потерю ![](https://latex.codecogs.com/gif.latex?\varepsilon&space;_{i}=L(\left&space;\langle&space;w,x_{i}&space;\right&space;\rangle&space;y_{i}))
 ![](https://latex.codecogs.com/gif.latex?X=\mathbb{R}^{n&plus;1},&space;Y\subseteq&space;\mathbb{R})
6: градиентный шаг: ![](https://latex.codecogs.com/gif.latex?w=w-\eta&space;L(\left&space;\langle&space;w,x_{i}&space;\right&space;\rangle&space;y_{i})x_{i}y_{i})

7: оценить значение функционала: ![](https://latex.codecogs.com/gif.latex?Q=(1-\lambda&space;)Q&plus;\lambda&space;\varepsilon&space;_{i})

8: пока значение *Q* и/или веса *w* не стабилизируются.

ADALINE
-------
Задача регрессии: ![](https://latex.codecogs.com/gif.latex?X=\mathbb{R}^{n&plus;1},&space;Y\subseteq&space;\mathbb{R}),
![](https://latex.codecogs.com/gif.latex?L(a,y)=(a-y)^{2}) - квадратичная функция потерь. Адаптивный линейный элемент (ADALINE).

Градиентный шаг - дельта-правило (delta-rule):
![](https://latex.codecogs.com/gif.latex?w=w-\eta&space;((w,x_{i})-y_{i})x_i,&space;(w,x_{i})-y_{i}=\Delta&space;_{i}) - ошибка алгоритма на объекте ![](https://latex.codecogs.com/gif.latex?x_i).

Программная реализация стохастического градиента для ADALINE:
```diff
# Стохастический градиент для ADALINE
sg.ADALINE <- function(xl, eta = 1, lambda = 1/6)
{
  l <- dim(xl)[1]
  n <- dim(xl)[2] - 1
  w <- c(1/2, 1/2, 1/2)
  iterCount <- 0
  
  # инициализация Q
  Q <- 0
  for (i in 1:l)
  {
    # вычисление скалярного произведения <w,x>
    wx <- sum(w * xl[i, 1:n])
    # вычисление отступа
    margin <- wx * xl[i, n + 1]
    
    Q <- Q + lossQuad(margin)
  }
  
  repeat
  {
    # вычисление отступа для все объектов обучаемой выборки
    margins <- array(dim = l)
    for (i in 1:l)
    {
      xi <- xl[i, 1:n]
      yi <- xl[i, n + 1]
      
      margins[i] <- crossprod(w, xi) * yi
    }
    
    # выбор ошибочных объектов
    errorIndexes <- which(margins <= 0)
    
    if (length(errorIndexes) > 0)
    {
      # рандомный выбор индексов из ошибок
      i <- sample(errorIndexes, 1)
      iterCount <- iterCount + 1
      
      xi <- xl[i, 1:n]
      yi <- xl[i, n + 1]
      
      # вычисление скалярного произведения <w,xi>
      wx <- sum(w * xi)
      
      # производится шаг градиента
      margin <- wx * yi
      
      # вычисление ошибок
      ex <- lossQuad(margin)
      eta <- 1 / sqrt(sum(xi * xi))
      w <- w - eta * (wx - yi) * xi
      
      # вычисление нового Q
      Qprev <- Q
      Q <- (1 - lambda) * Q + lambda * ex
    }
    else
    {
      break
    }
  }
  return (w)
}

```

Результат программной реализации ADALINE:
![](https://github.com/icyvan/DataMining/blob/master/images/adaline2.png)

Персептрон Розенблатта
----------
Этот алгоритм имеет кусочно-линейную функцию потерь ![](https://latex.codecogs.com/gif.latex?L(M)=(-M)_{&plus;}).

Этот алгоритм формализуется с помошью **правила Хэбба**:

**если** ![](https://latex.codecogs.com/gif.latex?\left&space;\langle&space;w,x_{i}&space;\right&space;\rangle&space;y_{i}&space;<&space;0) **то** ![](https://latex.codecogs.com/gif.latex?w=w&plus;\eta&space;x_{i}y_{i})

![](https://github.com/icyvan/DataMining/blob/master/images/Perceptron.png)

Логистическая	регрессия
-------






