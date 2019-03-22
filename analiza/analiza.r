# 4. faza: Analiza podatkov

zakonske <- subset(tabela1A, Spremenljivka == "Stevilo.sklenjenih.zakonskih.zvez")

fit <- lm(data = zakonske, Vrednost ~ Leto)

cas <- data.frame(Leto=seq(1998, 2030, 2))

predict(fit, cas)

napoved <- cas %>% mutate(Vrednost=predict(fit, .))

graf5 <- ggplot(zakonske, aes(x=Leto, y=Vrednost)) +
  geom_smooth(method=lm, se=FALSE, fullrange = TRUE) +
  geom_point(data=zakonske, aes(x=Leto, y=Vrednost), color="red", size=4) +
  labs(title="Napoved števila porok", y="Število porok") + geom_point()
