# Tipos de datos 

Para realizar un uso eficiente de R es preciso entender y aprender a manipular bien las distintas clases de objetos que maneja el programa. En esta sección nos vamos a ocupar particulamente de aquellos objetos que R utiliza para representar datos: valores, vectores y dataframes (hay más), y su naturaleza. 

Para un procesamiento correcto, un lenguaje de programación debe saber qué se puede y qué no se puede hacer con un valor en particular. Por ejemplo, no se puede sumar palabras "hola" y "mundo".

Del mismo modo, no puede cambiar los números 1 y -34.5 de minúsculas a mayúsculas. Debido a esto, R tiene una característica llamada tipos de datos. 

R proporciona las funciones class () y typeof () para averiguar cuál es la clase y el tipo de cualquier variable. R tiene cinco tipos de datos que son:

<table class="table" style="font-size: 15px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Clase </th>
   <th style="text-align:left;"> Ejemplo </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> numérica </td>
   <td style="text-align:left;"> 12.3, 5, 999, ... </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lógica </td>
   <td style="text-align:left;"> TRUE, FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> caracter </td>
   <td style="text-align:left;"> hola, JUAN... </td>
  </tr>
  <tr>
   <td style="text-align:left;"> fecha </td>
   <td style="text-align:left;"> 2021-05-06, 31/01/1965 </td>
  </tr>
</tbody>
</table>

## Vectores

En términos genéricos, todos los elementos que maneja R se consideran objetos: un valor numérico es un objeto, un vector es un objeto, una función es un objeto, una base de datos es un objeto, un gráfico es un objeto...

La unidad básica de datos en R es un vector, los cuales pueden ser de diferentes clases. Los que más usaremos son las siguientes clases. 

`vector <- c(Concatenación, de, elementos, atómicos)`


```r
# v0 <- 8,9,11
v0 <- c(8,9,11)
# v00 <- c(8)
str(v0)

v01 <- c(8,9,11)
typeof(v01)

v0+v01
```


```r
v1 <- c(8, 7, 9, 10, 10, 111)
v1
typeof(v1)
str(v1)
summary(v1) 
```

> Supongamos que v1 es una muestra de la variable largo de raiz de trigo en cm  


```r
plot(v1)

edit(v1)
v1
v1 <- edit(v1) 
v1
```


```r
# Medidas de posición
mean(v1) 
median(v1)
quantile(v1, 0.25)

# Medidas de dispersión
min(v1)
max(v1)
range(v1)
var(v1)
sd(v1)
sqrt(var(v1))
```

* Operaciones con vectores numéricos


```r
v1 - 1
sum(v1)
cumsum(v1)
```

## Numéricos {-}

Tipos: `integer` vs `double`


```r
num <- 8
class(num)
typeof(num)

inte <- as.integer(num)
class(inte)
typeof(inte)

num + inte

# inte2 <- 8L
```

## Lógicos {-}

El tipo de dato lógico o booleano es en computación aquel que puede representar valores de lógica binaria, esto es 2 valores: falso o verdadero


```r
logi <- FALSE # logi <- false
class(logi)
typeof(logi)

as.logical(0)
as.logical(1)
```

## Caracter {-}

Almacena valores de "caracteres" o "cadenas" (en inglés "string"): pueden contener letras, números y símbolos. La forma más sencilla de indicar que un valor es de tipo carácter es colocar el valor entre comillas simples o dobles.


```r
car <- "Hola mundo" # carac <- 'hola mundo' 
class(car)
typeof(car)

car2 <- as.character("Hola mundo")
car3 <- as.character(num)
typeof(car3)
```

## Fechas {-}

Almacena valores de "caracteres" o "cadenas" (en inglés "string"): pueden contener letras, números y símbolos. La forma más sencilla de indicar que un valor es de tipo carácter es colocar el valor entre comillas simples o dobles.

* El formato default es yyyy-mm-dd


```r
fechas_vector <- as.Date(c("2007-06-22", "2004-02-13"))
str(fechas_vector)
```

* Pero nosostros comunmente usamos 'dd/mm/yyyy', así que debemos convertir


```r
fechas <- c("01/06/2020", "31/12/2020")
str(fechas)

fechas_date <- as.Date(fechas, "%d/%m/%Y") # con paquete base
fechas_date <- lubridate::dmy(fechas) # con lubridate!
str(fechas_date)
diff(fechas_date)
```

:::{#box1 .blue-box}

* Forzando las clases explícitamente

`as.character()`, `as.numeric()`, `as.integer()` y `as.logical()` 

Si colocáramos dos o más clases diferentes dentro de un mismo vector, R va forzar a que todos los elementos pasen a pertenecer a una misma clase. El número 1.7 cambiaría a  "1.7" si fuera creado junto con "a".


```r
y1 <- c(1.7, "a")  ## character
class(y1)

y2 <- c(TRUE, 0, 10)   ## numeric
class(y2)

y3 <- c(TRUE, "a") ## character
class(y3)

y4 <- c(T, F)
class(y4)

as.numeric(y1)
as.numeric(y3)
as.numeric(y4)
as.logical(y2)
```
:::

## Secuencias

### Numéricas {-}


```r
1:7  
seq(from = 0, to = 20, #by=2) # 
    length=4) 

rep(1:3, times=3) #  , each=3   
```

### Letras {-}


```r
LETTERS  
rep(c("a","b", "c"), times=3) #  , each=3   
```

### Fechas {-}


```r
seq(as.Date("2015-01-15"), as.Date("2015-12-15"), "1 month")
```

## Números aleatorios

La generación de números aleatorios es en muchas ocasiones un requerimiento esencial en investigación científica. Proceder de este modo puede reducir cualquier sesgo generado por nuestra persona a la hora de seleccionar una muestra, o aplicar un tratamiento a una unidad experimental. 

* Generar números enteros de modo aleatorio de una muestra determinada

`sample()` 


```r
set.seed(123)
sample(1:30, size=10, replace=F) #sin reposición
```

* Generar números aleatorios de una distribución específica de parámetros conocidos: 

`runif()` - números racionales aleatoriamente, uniformemente distribuidos en un intervalo


```r
num_unif <- runif(100, min=3, max=4)
hist(num_unif)
```

`rnorm()` - números aleatorios, pertenecientes a una población con [distribución normal](https://en.wikipedia.org/wiki/68%E2%80%9395%E2%80%9399.7_rule), con parámetros μ y σ.


```r
num_norm <- rnorm(100, mean=70, sd=5) 
hist(num_norm)
```

## Valores especiales

Existen valores reservados para representar datos faltantes, infinitos, e indefiniciones matemáticas.

* NA (Not Available) significa dato faltante/indisponible. El NA tiene una clase, o sea, pueden ser NA numeric, NA character, etc.


```r
y <- c(2, 4, NA, 6)
is.na(y)
```

> Calcule el promedio de y (use la ayuda de R en caso necesario)`mean(y)`

* NaN (Not a Number) es el resultado de una operación matemática inválida, ej:  0/0 y log(-1). 
Un NaN es un NA, pero no recíprocamente.


```r
0/0
is.nan(0/0)
is.na(0/0)
```

* `NULL` es el vacío de R. Es como si el objeto no existiese


```r
a = NULL
a
```

* `Inf` (infinito). Es el resultado de operaciones matemáticas cuyo límite es infinito, es decir, es un número muy grande, por ejemplo, 1/0 o 10^310. Acepta signo negativo -Inf.


```r
1/0
1/Inf
```

## Factores

En R las variables categóricas se almacenan como **factores** tanto sea para vectores que contienen caracteres o enteros. Uno de los usos más importantes de los factores es en el modelado estadístico, dado que éstos tendran un efecto diferente a las variables contínuas. Claro ejemplo de factores son los tratamientos, por ej: fungicidas, genotipos, bloques, etc.  

Todo factor tiene sus atributos:  

- x: el vector input (de tipo numérico o caracter) que será transformado a factor. 
- Niveles (`levels`): es un set de valores únicos ordenados que aparecen en x. 

Podemos comprobar que la ordenación de los niveles es simplemente alfabética. 


```r
geno <- c("control", "B35", "A12", "T99", "control", "A12", "B35", "T99", 
"control", "A12", "B35", "T99", "control")
class(geno)
levels(geno)

geno_f <- factor(geno)
levels(geno_f)
table(geno_f)

geno_f1 <- factor(geno, levels=c("control", "A12", "B35", "T99"))
levels(geno_f1)
```


```r
trat <- c(3, 5, 7, 1, 1, 5, 5, 7,5)
trat_f <- factor(trat)
trat_f
levels(trat_f)
table(trat_f)
```

:::{#box1 .blue-box}

Las variables **numéricas y de caracteres** se pueden convertir en factores (factorizar), pero los niveles de un factor siempre serán valores de **caracteres**. Podremos verlo en el siguiente ejemplo:


```r
vec_n <- c(3, 7, 2)
sum(vec_n)

vec_f <- factor(vec_n)
vec_f
levels(vec_f)
labels(vec_f)

vec_fn  <- as.numeric(vec_f)
vec_fn; vec_n
identical(vec_fn, vec_n)

sum(vec_n)

# ¿Cómo hizo la transformación R? Hemos recuperado los valores numéricos 
# originales (`vec`)? que representan los números codificados por R 
# en `vec_f`? 

vec_fcn  <- as.numeric(as.character(vec_f))
sum(vec_fcn)
identical(vec_n, vec_fcn)
```
:::
