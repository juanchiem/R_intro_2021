```{r}
?ToothGrowth
tg <- ToothGrowth
```

- Exploración

```{r}
str(tg) # tipo de variables
```

```{r}
tg1 <- tg %>% mutate_at(vars(dose), as.factor)
```

```{r}
summary(tg1) # exploración numérica
```

```{r}
# exploracion numerica por tratamiento
tg1 %>%
  group_by(supp, dose) %>%
  skim()
# summarise(
#   count = sum(!is.na(len)),
#   mean = mean(len, na.rm = TRUE),
#   sd = sd(len, na.rm = TRUE)
# )
```

¿cómo podemos reconocer un efecto de interacción? tratamos de notar si la relación entre un factor "A" y la variable respuesta es diferente para diferentes niveles de otro factor "B".

Con dos factores categóricos, que a menudo es el escenario que nos interesa, el enfoque de diagrama de caja en paralelo puede funcionar bastante bien:

  ```{r}
# Version 1
tg1 %>%
  ggplot()  +
  aes(x = dose, y = len, col = supp) +
  geom_boxplot()
# geom_line(aes(group=supp), stat = "summary", fun=mean)

# Version 2
tg1 %>%
  ggplot() +
  aes(x = supp, y = len, color = dose)+
  geom_boxplot()
```

Ajustar modelo

```{r}
tooth_mod <-  lm(len ~ supp * dose, data=tg1)
drop1(tooth_mod, test = "F")
# equivale a supp + dose + supp:dose
```

- Diagnósticos

¿Las varianzas (entre niveles del factor) son homogéneas?

  ```{r}
check_heteroscedasticity(tooth_mod) # %>% plot
# plot(mod1, which = 1)
# car::leveneTest(mod1)
```

¿Los residuos se distribuyen normales?

  ```{r}
check_normality(tooth_mod) # %>% plot
# plot(mod1, which = 2)
# shapiro.test(rstandard(mod1))
```

avanzamos...

```{r}
anova(tooth_mod)
summary(tooth_mod)
```

- comparaciones múltiples (un factor dentro del otro)

```{r}
pacman::p_load(emmeans, multcomp)
# emmip(mod2, supp~ dose)
```

```{r}
tooth_em <- emmeans(tooth_mod,  ~ supp|dose, adjust="tukey")
cld(tooth_em, alpha=.05, Letters=letters)
```

```{r}
tooth_em2 <- emmeans(tooth_mod,  ~ dose|supp, adjust="tukey")
cld(tooth_em2, alpha=.05, Letters=letters)
```

```{r}
tooth_em3 <- emmeans(tooth_mod, ~supp*dose, adjust="tukey")
cld(tooth_em3, alpha=.05, Letters=letters)
```
