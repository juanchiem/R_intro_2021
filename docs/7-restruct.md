---
output: html_document
editor_options: 
  chunk_output_type: inline
---
## `join()`

Retomemos los datos de bce_met2 que por suerte los tenemos guardados como .Rdata para un rapido retome (nos ahorramos los pasos anteriores)


```r
# paquetes que iremos a usar en esta sesion
pacman::p_load(tidyverse, lubridate, rio, janitor, nasapower)
# datos guardados en la sesion previa
load("data/datos_curso.Rdata")
```

Nos acaban de pasar los datos de lluvias de Balcarce en 2018


```r
bce_lluvias_raw  <- rio::import("data/datos_curso.xls", sheet ="bce_lluvias")
```

seria interesante poder acoplar a nuestro dataset `bce_met2`

![](fig/joins.png){width=300px}

Veamos los datos meteorologicos de Balcarce:


```r
bce_met2
bce_lluvias_raw 
```

Si hacemos la misma conversion fecha a date tendriamos una columna en comun 


```r
bce_lluvias <- bce_lluvias_raw %>% 
  mutate(date = dmy(fecha)) %>% 
  select(-fecha)

str(bce_lluvias)
```
Ahora hagamos uso de `left_join()` para que matcheen las filas y se peguen la columna de lluvia a bce_met2


```r
bce_full <- bce_met2 %>% 
  left_join(bce_lluvias, by="date") 

str(bce_full)

# veamos otra utilidad mas de mutate!
bce_full <- bce_met2 %>% 
  left_join(bce_lluvias, by="date") 
  mutate(pp = replace_na(pp, 0))

str(bce_full)
```


```r
ggplot(bce_full) + 
  aes(x=date)+
  geom_col(aes(y = pp)) + 
  theme_bw() + 
  scale_x_date(date_breaks = "1 month", date_labels = "%b",
               limits = as.Date(c("2018-06-01", "2018-31-12")))+
  theme(axis.text.x = element_text(angle=45, hjust = 1))
```

# {tidyr}

Contiene funciones para  re-estructurar dataframes. Similar al conocido "transponer" de excel. 
 
(fig/tidyr-pivot_wider_longer.gif)

## `pivot_longer()`

Por lo general en la etapa de toma de datos en el campo/lab (y su consiguiente pasaje a planilla electrónica, Excel) nos resulta más cómodo que las planillas de papel tengan un formato *wide*.  

En muchas ocasiones necesitamos (para graficar o modelar) que nuestros datos estén en formato *long*. 

La función `pivot_longer` apila las columnas que indiquemos, re-arregando los datos de un formato "wide" a "long":


Importemos  **soja**


```r
soja  <- rio::import("data/datos_curso.xls", sheet ="soja")
soja
```

En este caso necesitamos generar una columna `bk` y `yield`, o sea, tornar soja de "wide" a "long": 


```r
soja %>% 
  pivot_longer(cols=c(bk_1, bk_2, bk_3, bk_4), # contains("_") # bk_1:bk_4
               names_to = "bk", 
               values_to = "yield", 
               names_prefix = "bk_") -> soja_long 
```

Tambien es comun para medidas repetidas en el tiempo


```r
canola  <- rio::import("data/datos_curso.xls", sheet ="canola")
canola
```


```r
canola %>%  
  pivot_longer(
    cols=contains("_"),
    names_to = "tt",
    values_to = "inc", 
    names_prefix = "inc_")-> can_long

can_long
str(can_long)
```


```r
can_long %>% 
  mutate_at("tt", as.numeric) %>% 
  ggplot()+
  aes(x=tt, y=inc, group=1)+
  geom_line() + 
  facet_grid(bk ~ trt)
```

## `unite()`


```r
can_long %>% 
  unite(col="par", bk, trt, sep = "_", remove = FALSE) -> can_long2

can_long2 %>% 
  mutate_at("tt", as.numeric) %>% 
  ggplot()+
  aes(x=tt, y=inc, group=1)+
  geom_line() + 
  facet_wrap("par")
```

:::{#box1 .blue-box}


```r
bce_full %>% 
  select(date, tmean, rad, pp) %>% 
  pivot_longer(cols = -date, 
               names_to = "var", 
               values_to = "val") -> bce_full_long 
bce_full_long 
```


```r
# bce_full_long %>% 
  # mutate(
  #   var= fct_recode(var,
  #                       "Radiation (Mj/m2)" ="rad", 
  #                       "Mean Temperature (ºC)"="tmean", 
  #                       "Precipitation (mm)"="pp") 
  # ) %>% 

ggplot(bce_full_long) + 
  aes(x = date, y = val) +  
  geom_line(data = subset(bce_full_long, var!="pp")) + 
  geom_col(data = subset(bce_full_long, var=="pp")) + 
  facet_grid(var~., scales = "free") + 
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+ 
  theme_bw() + 
  theme(axis.text.x = element_text(angle=45, hjust = 1))  + 
  labs(x="", y="")
```
:::

# Otras importaciones 

## Importación multiple con {rio}


```r
library(rio)

bce_serie <- bind_rows(
  import_list(file= "data/eea_serie.xls"),
  .id = "year")

bce_serie
```

## Desde googlesheets

Importemos "soja"


```r
url_soja <- "https://docs.google.com/spreadsheets/d/1c_FXVNkkj4LD8hVUForaaI24UhRauh_tWsy7sFRSM2k/edit#gid=1579441844"
browseURL(url_data)

soja <- rio::import(url_soja) %>% 
  clean_names()
soja
```

## API de Nasapower

Meteo de Balcarce durante 2020


```r
pacman::p_load(nasapower)

bce_rad_2018 <- get_power(
  community = "AG",
  lonlat =  c(-58.3, -37.75),
  pars = c("ALLSKY_SFC_SW_DWN"),
  dates = c("2018-1-1", "2018-12-30"),
  temporal_api = "daily"
) 
bce_rad_2018
```

Clima de Balcarce


```r
bce_clima <- get_power(
  community = "ag",
  pars = c("RH2M", "T2M", "ALLSKY_SFC_SW_DWN"),
  lonlat = c(-58.3, -37.75),
  temporal_api = "climatology"
)
bce_clima
```

Comparamos la estacion meteorologica de la EEA con los datos de nasapower


```r
bce_full %>% 
  left_join(bce_rad_2018, 
            by = c("date" = "YYYYMMDD")) -> bce_full_nasa
```



```r
bce_full_nasa %>% 
  ggplot() + 
  aes(x=rad, y=ALLSKY_SFC_SW_DWN) + 
  geom_point() + 
  geom_smooth(method="lm")
```


## Exportar


```r
export(bce_full_nasa, file="data/bce_wea_2018.xlsx")
```

