# Метрические алгоритмы классификации

Метрический алгоритм - алгоритм классификации основанный на оценке близости объектов, используя функцию расстояния. 

При этом метрические алгоритмы основываются на гипотезе компактности, которая говорит, что схожим объектам соответствуют схожие ответы.

Метрические методы обучения - методы, основанные на анализе сходства объектов.

Алгоритм k ближайших соседей (kNN)
---------------- 
 Метрический алгоритм классификации с обучающей выборкой <img src="http://www.sciweavers.org/tex2img.php?eq=X%5El&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="X^l" width="21" height="19" /> относит объект u к тому классу y, для которого суммарный вес ближайших обучающих объектов <img src="http://www.sciweavers.org/tex2img.php?eq=W_y%28u%2CX%5El%29&bc=White&fc=Black&im=jpg&fs=12&ff=ccfonts,eulervm&edit=0" align="center" border="0" alt="W_y(u,X^l)" width="79" height="22" /> максимален:
 
<img src="http://www.sciweavers.org/tex2img.php?eq=W_y%28u%2CX%5El%29%3D%20%5Csum%20w%28i%2Cu%29&bc=White&fc=Black&im=jpg&fs=12&ff=ccfonts,eulervm&edit=0" align="center" border="0" alt="W_y(u,X^l)= \sum w(i,u)" width="178" height="29" />,
 
где весовая функция <img src="http://www.sciweavers.org/tex2img.php?eq=w%28i%2Cu%29&bc=White&fc=Black&im=jpg&fs=12&ff=ccfonts,eulervm&edit=0" align="center" border="0" alt="w(i,u)" width="57" height="19" /> оценивает степерь важности i-го соседа классификации объекта u.

Функция <img src="http://www.sciweavers.org/tex2img.php?eq=W_y%28u%2CX%5El%29&bc=White&fc=Black&im=jpg&fs=12&ff=ccfonts,eulervm&edit=0" align="center" border="0" alt="W_y(u,X^l)" width="79" height="22" /> - наз оценкой близости u к классу y.
 
Алгоритм k ближайших соседей - **kNN** отоносит объект к тому классу элементов, которого больше среди k ближайших соседей <img src="http://www.sciweavers.org/tex2img.php?eq=x_u&bc=White&fc=Black&im=jpg&fs=12&ff=ccfonts,eulervm&edit=0" align="center" border="0" alt="x_u" width="19" height="12" />.
Имеется некоторая выборка <img src="http://www.sciweavers.org/tex2img.php?eq=x%5El&bc=White&fc=Black&im=jpg&fs=12&ff=ccfonts,eulervm&edit=0" align="center" border="0" alt="x^l" width="17" height="18" />, состоящая из объектов <img src="http://www.sciweavers.org/tex2img.php?eq=x%28i%29%2C%20i%20%3D%201%2C%20...%2C%20l&bc=White&fc=Black&im=jpg&fs=12&ff=ccfonts,eulervm&edit=0" align="center" border="0" alt="x(i), i = 1, ..., l" width="108" height="19" /> (Мы будем испольховать Ирисы Фишера).
