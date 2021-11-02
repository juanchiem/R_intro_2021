# R Markdown

R Markdown provee un marco de escritura para ciencia de datos, que combina tu código, sus resultados y tus comentarios en prosa. Los documentos de R Markdown son completamente reproducibles y soportan docenas de formatos de salida tales como PDFs, archivos de Word, presentaciones y más.

Los archivos R Markdown están diseñados para ser usados de tres maneras:

1. Para comunicarse con quienes toman decisiones, que desean enfocarse en las conclusiones, no en el código que subyace al análisis.

1. Para colaborar con otras personas que hacen ciencia de datos, quienes están interesados tanto en tus conclusiones como en el modo en el que llegaste a ellas (es decir, el código).

1. Como si fuera un notebook de laboratorio moderno donde puedes capturar no solo que hiciste, sino también lo que estabas pensando cuando lo hacías.

# Elementos básicos de R Markdown

Este es un archivo R Markdown, un archivo de texto plano que tiene la extensión `.Rmd`:



Contiene tres tipos importantes de contenido:

1.  Un **encabezado YAML** (opcional) rodeado de `---`s.
2.  **Chunks**  de código de R rodeados de ```` ``` ````.
3.  Texto mezclado con formateos de texto simple como `# Encabezado` e `_italicas_`.

Cuando abres un archivo `.Rmd`, obtienes una interfaz de notebook donde el código y el output están intercalados. Puedes ejecutar cada bloque de código haciendo clic en el ícono ejecutar (se parece a un botón de reproducir en la parte superior del bloque de código), o presionando `Ctrl + Shift + Enter`. RStudio ejecuta el código y muestra los resultados incustrados en el código.

Para producir un reporte completo que contenga todo el texto, código y resultados, haz clic en “Knit” o presionar `Ctrl + Shift + K`. Esto mostrará el reporte en el panel viewer y creará un archivo HTML independiente que puedes compartir con otras personas

## Formateo de texto con Markdown 



Formato de texto
------------------------------------------------------------

*cursiva*   o _cursiva_
**negrita**   __negrita__
`code`
superíndice^2^ y subíndice~2~

Encabezados
------------------------------------------------------------

# Encabezado de primer nivel

## Encabezado de segundo nivel

### Encabezado de tercer nivel

Listas
------------------------------------------------------------

*   Elemento 1 en lista no enumerada

*   Elemento 2

    * Elemento 2a

    * Elemento 2b

1.  Elemento 1 en lista enumerada

1.  Elemento 2. La numeración se incrementa automáticamente en el output.

Enlaces e imágenes
------------------------------------------------------------

<https://es.r4ds.hadley.nz/> Español

<https://r4ds.had.co.nz/> Inglés

[texto del enlace](https://es.r4ds.hadley.nz/)

![pie de página opcional](fig/top.jpg)

Tablas 
------------------------------------------------------------

Primer encabezado     | Segundo encabezado
--------------------- | ---------------------
Contenido de la celda | Contenido de la celda
Contenido de la celda | Contenido de la celda

## Bloques de código 

ara ejecutar código dentro de un documento R Markdown, necesitas insertar un bloque o chunk, en inglés. Hay tres maneras para hacerlo:

    Con el atajo de teclado: Cmd/Ctrl + Alt + I

    Con el ícono “Insert” en la barra de edición

    Tipeando manualmente los delimitadores de bloque ```{r} y ```.

Obviamente, nuestra recomendación es que aprendas a usar el atajo de teclado. A largo plazo, te ahorrará mucho tiempo.

Puedes continuar ejecutando el código usando el atajo de teclado que para este momento (¡esperamos!) ya conoces y amas : Cmd/Ctrl + Enter. Sin embargo, los bloques de código tienen otro atajo de teclado: Cmd/Ctrl + Shift + Enter, que ejecuta todo el código en el bloque. Piensa el bloque como una función. Un bloque debería ser relativamente autónomo y enfocado en torno a una sola tarea.

Las siguientes secciones describen el encabezado de bloque, que consiste en 


Opciones de los bloques

La salida de los bloques puede personalizarse con options, que son argumentos suministrados en el encabezado del bloque. Knitr provee casi 60 opciones que puedes usar para personalizar tus bloques de código. Aquí cubriremos las opciones de bloques más importantes que usarás más frecuentemente. Puedes ver la lista completa en http://yihui.name/knitr/options/.

El conjunto más importante de opciones controla si tu bloque de código es ejecutado y qué resultados estarán insertos en el reporte final:

`eval = FALSE` evita que el código sea evaluado. (Y, obviamente, si el código no es ejecutado no se generaran resultados). Esto es útil para mostrar códigos de ejemplo, o para deshabilitar un gran bloque de código sin comentar cada línea.

`include = FALSE` ejecuta el código, pero no muestra el código o los resultados en el documento final. Usa esto para código de configuración que no quieres que abarrote tu reporte.

`echo = FALSE` evita que se vea el código, pero sí muestra los resultados en el archivo final. Utiliza esto cuando quieres escribir reportes enfocados a personas que no quieren ver el código subyacente de R.

`message = FALSE` o warning = FALSE evita que aparezcan mensajes o advertencias en el archivo final.

`results = 'hide'` oculta el output impreso; fig.show = 'hide' oculta gráficos.

`error = TRUE` causa que el render continúe incluso si el código devuelve un error. Esto es algo que raramente quieres incluir en la versión final de tu reporte, pero puede ser muy útil si necesitas depurar exactamente qué ocurre dentro de tu .Rmd. Es también útil si estás enseñando R y quieres incluir deliberadamente un error. Por defecto, error = FALSE provoca que el knitting falle si hay incluso un error en el documento.

La siguiente tabla resume qué tipos de output suprime cada opción:

| Option              | Ejecuta | Muestra | Output | Gráficos | Mensajes | Advertencias |
|---------------------|----------|-----------|--------|-------|----------|----------|
| `eval = FALSE`      | \-       |           | \-     | \-    | \-       | \-       |
| `include = FALSE`   |          | \-        | \-     | \-    | \-       | \-       |
| `echo = FALSE`      |          | \-        |        |       |          |          |
| `results = "hide"`  |          |           | \-     |       |          |          |
| `fig.show = "hide"` |          |           |        | \-    |          |          |
| `message = FALSE`   |          |           |        |       | \-       |          |
| `warning = FALSE`   |          |           |        |       |          | \-       |

## Tablas

Por defecto, R Markdown imprime data frames y matrices tal como se ven en la consola:


```r
head(mtcars)
```

Si prefieres que los datos tengan formato adicional, puedes usar la función knitr::kable


```r
knitr::kable(
  head(mtcars), 
  caption = "A knitr kable."
)
```


## Opciones globales

A medida que trabajes más con knitr, descubrirás que algunas de las opciones de bloque por defecto no se ajustan a tus necesidades y querrás cambiarlas. Puedes hacer esto incluyendo `knitr::opts_chunk$set()` en un bloque de código. Por ejemplo, cuando escribimos un reporte para una persona no interesada en el código incluiremos en el seteo global:


```r
## Global options
knitr::opts_chunk$set(
  echo=FALSE,
  comment=NA,
  message=FALSE,
  warning=FALSE)
```

Esto ocultará por defecto el código, así que solo mostrará los bloques que deliberadamente has elegido mostrar (con `echo = TRUE`). 


Más info sobre `R Markdown` en <https://es.r4ds.hadley.nz/r-markdown.html>  


#Trabajo final de curso 

Pasos básicos para la elaboración del informe de proyectos personales

- importación de datos desde la propia PC o desde Google sheet

- renombre de variables

- descripción de Data frame  y clases de clases de variables

- exploración numérica de los datos

- exploración gráfica de los datos

- ajuste de algún modelo

- gráfico final

- conclusiones por extenso en escrito

* NOTA: son mas que bienvenidos todos los agregados personales que quieran hacer (incluir imágenes sobre los datasets, mapas, etc...)

