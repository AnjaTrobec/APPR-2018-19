# 4. faza: Analiza podatkov

nova <- subset(tabela1A, Spremenljivka == "Stevilo.sklenjenih.zakonskih.zvez")

fit <- lm(data = nova, Vrednost ~ Leto)

casovno <- data.frame(Leto=seq(1998, 2030, 2))

predict(fit, casovno)

napoved <- casovno %>% mutate(Vrednost=predict(fit, .))

graf5 <- ggplot(nova, aes(x=Leto, y=Vrednost)) +
  geom_smooth(method=lm, se=FALSE, fullrange = TRUE) +
  geom_point(data=nova, aes(x=Leto, y=Vrednost), color="orange", size=3) +
  labs(title="Napoved števila porok", y="Število porok") + geom_point()

