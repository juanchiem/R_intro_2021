# Sintaxis

## R Calculadora {-}


```r
4 + 9
4 - 
  3 *
  1
#4%1

(4 + 5 ) * 7 - (36/18)^3
```


:::{#box1 .blue-box}
Ver [tablas resumen](#tablas_resumen) de operadores aritméticos y lógicos (al final del capítulo) 
:::

> Reto matemático que se volvió viral en las redes sociales*

![](fig/reto.jpeg)

Existen dos soluciones, según método que se aplique: el PEMDAS = 1 (parenthesis < exponents < multiplicación < division < addition < subtraction) y el BODMAS = 16 (Brackets < Orders (Powers and Square Roots) < Division < Multiplication < Addition < Subtraction). 

> Cómo opera R?

Se puede decir que hay diferencia de estilos al programar. Se deberia tener presente que otros pueden leer tu código (optar por buenas prácticas)


```r
(3+(5*(2^2))) # difícil de leer
3 + 5 * 2 ^ 2   # si se recuerdan las reglas, todo bien
3 + 5 * (2 ^ 2)   # si se olvidan algunas reglas, esto podría ayudar
```

## Comparaciones lógicas {-}


```r
4>3
4 == 4
4 != 4
4 != 3
1 >= -9
```

</br>

## Variables y asignaciones {-}

Podemos almacenar valores en variables usando el operador de asignación `<-`, veamos un ejemplo:


```r
x <- 1/40
```

Esta asignación no muestra el valor, sino que lo almacena para más adelante en algo llamado "variable". Que contiene x?


```r
x
```
:::{#box1 .blue-box}
shortcut de "<-" : `Alt -`
:::

Chequear la pestaña Environment en uno de los paneles de RStudio. Nuestra variable x se puede usar en lugar de un número en cualquier cálculo que espere un número:


```r
x <- x + 1 # observen cómo RStudio actualiza/sobrescribe x en la pestaña superior derecha
y <- x * 2
```

El lado derecho de la asignación puede ser cualquier expresión de R válida. La expresión del lado derecho se evalúa por completo antes de que se realice la asignación.


También es posible utilizar el operador = para la asignación


```r
x = 1/40
```

Esta forma es menos común entre los usuarios R (se recomienda usar `<-`).

</br>

## Funciones {-}

Como dijimos, los paquetes son básicamente un conjunto de funciones generadas por los autores de los mismos pero el usuario puede crear sus propias funciones.

Componentes de las funciones:

nombre_funcion(argumentos)

* *Nombre*: Generalmente, el nombre es intuitivo, por ejemplo, `mean` es la función que calcula la media, `round` es la funión que redondea un número.(Como habrán notado R está en inglés) 

* *Argumentos*: Un argumento es un marcador de posición. Cuando se invoca una función, se debe indicar valores a los argumentos. Los argumentos son opcionales; es decir, una función puede no contener argumentos. También los argumentos pueden tener valores por defecto.

Algunos cálculos basados en funciones matemáticas. Son las mas simples, y no esta funcion no contienen argumentos.
[para chequear la info de la función, solo basta con seleccionar todos sus caracteres + F1]


```r
sqrt(3) 
# 3^0.5 
# 3^(1/2)
log(10) # logaritmo natural
exp(2.302585)
# log(10, base=10)
```

Funciones básicas pero con argumentos

* Redondeo 


```r
round(4.3478)  
round(4.3478, digits=3)  
```

## Tips {-}

1 - No se tienen en cuenta los espacios en blanco entre palabras: podemos o no dejar espacios para que el código se pueda ordenar de forma adecuada y poder entenderse.


```r
plot( pressure )
plot(pressur e)
```

2 - Se distinguen las mayúsculas y minúsculas (“case sensitive”): para variables en el código, podemos crear diferentes variables con nombres iguales pero alternando mayúsculas y minúsculas.


```r
Plot(pressure)
```

3 - Se pueden incluir comentarios: como vimos anteriormente los comentarios se utilizan para añadir información en el código. De paso observamos que 


```r
plot(pressur e) # da error

# grafico press vs temp
plot(pressure)
```

4 - El punto y coma (;) actúa como separador de comandos aún en la misma línea del script!


```r
pressure; plot(pressure)
```

5 - Los nombres de las variables pueden contener letras, números, guiones bajos y puntos, pero *NO PUEDEN*: 

+ comenzar con un número 
+ contener espacios en absoluto 

Cada uno adopta su propia forma para nombres largos de variables, por ej:

- puntos.entre.palabras
- guiones_bajos_entre_palabras
- MayúsculasMinúsculasParaSepararPalabras

No importa como lo adopten, pero es aconsejable ser consistente.

## S.O.S. {-}

- En el mismo R: `?sd`;  `??sd`; F1 sobre la función 

> Googlear: *r generate a sequence of uppercase letters* 

- [Stack Overflow en inglés](https://stackoverflow.com/) / [Stack Overflow en español](https://es.stackoverflow.com) / 
[RStudio](https://community.rstudio.com/): comunidades altamente activas por los usuarios de R y otros lenguajes de programación.

- [R Mailing Lists](https://www.r-project.org/mail.html): especificas de cada área de la ciencia. 

**¿Cómo hacer una buena pregunta en las comunidades?**

- Ser conciso pero gentil...

- Ser reproducible: su código debe correr en cualquier máquina. La comunidad no irá a ayudarle si no pueden reproducir su error (detallar paquetes y versión de R en caso necesario) 

## Tablas resumen { - #tablas_resumen}



<table class="table" style="font-size: 15px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:op-arit)Operadores aritméticos</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Operador </th>
   <th style="text-align:left;"> Detalle </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> `x + y` </td>
   <td style="text-align:left;"> Suma de x e y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x - y` </td>
   <td style="text-align:left;"> Resta de x menos y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x * y` </td>
   <td style="text-align:left;"> Multiplicación </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x / y` </td>
   <td style="text-align:left;"> División de x por y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x %/% y` </td>
   <td style="text-align:left;"> Parte entera de la división de x por y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x %% y` </td>
   <td style="text-align:left;"> Resto de la división de x por y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `x ^ y` </td>
   <td style="text-align:left;"> x elevado a y-ésima potencia (equivalente a **) </td>
  </tr>
</tbody>
</table>

<br><br>




<table class="table" style="font-size: 15px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:op-logi)Operadores lógicos</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Operador </th>
   <th style="text-align:left;"> Prueba.lógica </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> x &lt; y </td>
   <td style="text-align:left;"> x menor que y? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x &lt;= y </td>
   <td style="text-align:left;"> x menor o igual que y? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x &gt; y </td>
   <td style="text-align:left;"> x mayor que y? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x &gt;= y </td>
   <td style="text-align:left;"> x mayor o igual que y? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x == y </td>
   <td style="text-align:left;"> x igual que y? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x != y </td>
   <td style="text-align:left;"> x diferente que y? </td>
  </tr>
</tbody>
</table>

<br>
<br>




<table class="table" style="font-size: 15px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:matem)Funciones matemáticas</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Operador </th>
   <th style="text-align:left;"> Detalle </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> `sqrt(x)` </td>
   <td style="text-align:left;"> raiz de x </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `exp(y)` </td>
   <td style="text-align:left;"> exponencial de y </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `log(x)` </td>
   <td style="text-align:left;"> logaritmo natural de x = ln </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `log10(x)` </td>
   <td style="text-align:left;"> logaritmo base 10 de x </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `sum(x)` </td>
   <td style="text-align:left;"> suma todos los elementos de x </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `prod(x)` </td>
   <td style="text-align:left;"> producto de todos los elementos de x </td>
  </tr>
  <tr>
   <td style="text-align:left;"> `round(x, n)` </td>
   <td style="text-align:left;"> redondea x a n-digitos </td>
  </tr>
</tbody>
</table>

<br>
<br>




<table class="table" style="font-size: 15px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:shortcuts)Algunos atajos comúnmente usados</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Teclas </th>
   <th style="text-align:left;"> Detalle </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Alt+Shift+K </td>
   <td style="text-align:left;"> panel de todos los atajos </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+Z / Ctrl+Shift+Z </td>
   <td style="text-align:left;"> undo/redo </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Alt+ - </td>
   <td style="text-align:left;"> &lt;- </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+r </td>
   <td style="text-align:left;"> corre la línea/bloque completa de código </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+l </td>
   <td style="text-align:left;"> limpia la consola </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+Shift+c </td>
   <td style="text-align:left;"> silencia la línea de código </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+Shift+d </td>
   <td style="text-align:left;"> duplica la línea de código </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ctrl+i </td>
   <td style="text-align:left;"> indexa el bloque de código </td>
  </tr>
</tbody>
</table>

* Ver todos los atajos en R Studio: situandose en la consola >> `Ctrl | Shift | k` 

---
