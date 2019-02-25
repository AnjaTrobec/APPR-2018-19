# 4. faza: Analiza podatkov

# osnovni.podatki <- tabela4
# print(osnovni.podatki)
# ociscena <- subset(osnovni.podatki, spremenljivka = stevilo)
# fit <- lm(data = ociscena, vrednost = leto)
# a <- data.frame(leto=seq(2016, 2030, 2))
# predict(fit, a)
# napoved <- a %>% mutate(vrednost=predict(fit, .))
# graf5 <- ggplot(ociscena, aes(x=leto, y=stevilo)) +
#   geom_smooth(method=lm, se=FALSE, fullrange = TRUE) +
#   geom_point(data=napoved, aes(x=leto, y=stevilo), color="orange", size=3) +
#   labs(title="Napoved števila istospolnih porok", y="Število porok") + geom_point()

