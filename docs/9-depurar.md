# Depuración

* Activemos los paquetes


```r
pacman::p_load(tidyverse, janitor, refinr, skimr)
```

`{janitor}` `{refinr}` `{skimr}`

Retomemos el dataset `maiz`


```r
url_mz <- "https://docs.google.com/spreadsheets/d/1c_FXVNkkj4LD8hVUForaaI24UhRauh_tWsy7sFRSM2k/edit#gid=1706724730"

maiz_raw <- gsheet::gsheet2tbl(url_mz)
maiz_raw
```

que observan?


```r
maiz <- maiz_raw %>% 
  janitor::clean_names() %>% 
  rename(has = superficie_has, 
         rinde = rinde_qq_ha, 
         fs=fecha_de_siembra_dd_mm)

maiz
```

## Separar - unir columnas 


```r
maiz1 <- maiz %>% 
  separate(campana, c("ano_siembra", "ano_cosecha"), remove=FALSE) %>% 
  unite(f_siembra, c(ano_siembra,fs), sep = "/") %>% 
  mutate(f_siembra = lubridate::ydm(f_siembra))
```


```r
maiz1 %>% 
  count(hibrido) %>% 
  arrange(hibrido)
```

## Depuración de variables tipo carácter


```r
maiz1 %>% 
  mutate(hibrido = str_replace_all(hibrido, " ", "")) %>% 
  mutate(hibrido = refinr::n_gram_merge(hibrido)) %>% 
  count(hibrido) %>% 
  arrange(hibrido)

maiz2 <- maiz1 %>% 
  mutate(hibrido = str_replace_all(hibrido, " ", "")) %>% 
  mutate(hibrido = n_gram_merge(hibrido))

maiz2 
```

## Exploración rápida del dataset


```r
skimr::skim(maiz)
```

* Evolucion superficie por zona  


```r
sup_mz <- maiz2 %>% 
  group_by(zona, campana) %>% 
  summarise(super = sum(has, na.rm = TRUE) %>% round)
sup_mz
```


```r
sup_mz %>% 
  ggplot()+ 
  aes(x = campana, y = super, fill = zona) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label = super), 
            position = position_stack(vjust = 0.5),
            col = "white", fontface = "bold", size = 4)
```

Cuantos lotes por hibrido/zona  


```r
maiz2 %>% 
  tabyl(hibrido,zona) %>% 
  adorn_totals()
```

Que superficie por hibrido


```r
maiz2 %>% 
   group_by(zona, campana) %>% 
   summarise(super = sum(has))
```



```r
maiz2 %>% 
  group_by(zona) %>%
  summarise(lotes= n(), 
            sup = sum(has, na.rm = TRUE),
            rinde_median = median(rinde, na.rm = TRUE),  
            rinde_95 = quantile(rinde, .95, na.rm = TRUE))  
```


:::{#box1 .blue-box}

## Performance de hibridos de maíz

Filtremos el dataset: nos quedamos con aquellos hibridos presentes en al menos 10 lotes, con daño por factores abioticos < 10%, y rinde > 25 qq/haa


```r
hibridos <- maiz2 %>% 
  drop_na(rinde) %>% 
  filter(rinde>25) %>% 
  filter(dano_total<10) %>% 
  group_by(hibrido) %>%
  summarise(lotes = n(), 
            superficie = sum(has, na.rm = TRUE),
            rinde_med = median(rinde, na.rm = TRUE)) %>%
  arrange(desc(lotes)) %>%
  group_by(hibrido) %>%
  filter(any(lotes>9)) %>% 
  select(hibrido, rinde_med, lotes)
```



```r
hib_mz <- hibridos %>% 
  left_join(maiz2, by = "hibrido") %>% 
  filter(rinde>25) %>% 
  filter(dano_total<10) 

hib_mz %>% 
  ggplot()+
  aes(x=fct_reorder(hibrido, rinde_med, .desc = F), y=rinde)+
  geom_boxplot(width = 0.2, fill ="steelblue")+
  coord_flip()+
  geom_text(data=hibridos, 
            aes(y = rinde_med, label = rinde_med), vjust = 1, size =3)+
  geom_text(data=hibridos,
            aes(y = -Inf, label =  lotes), 
            hjust = 0, size =3)+
  labs(x = "", 
       y = "qq/ha",
       title = "Rendimiento híbridos en secano", 
       caption = "- Híbridos presentes en al menos 5 lotes\n- Nro al lado del hibrido = n° de lotes\n- Excuidos: lotes con 10% daño x adversidades")+
  theme_bw()
```

:::

