library(ggplot2)

env = read.csv("data/env_values.csv")
env = env[complete.cases(env),]

env = subset(env, value_of_env_protection > -1)

par(mfrow = c(1,2), mar = c(2.5, 2.5, 1, 0.5), mgp = c(1.5, 0.5, 0))

hist(env$env_education, main = "environmental education", 
	 breaks = seq(-0.5, 5.5, 1))
hist(env$value_of_env_protection, main = "value of env. protection", 
	 breaks = seq(-0.5, 7.5, 1))

plot(value_of_env_protection ~ env_education, data = env, pch = 16)
plot(jitter(value_of_env_protection) ~ jitter(env_education), 
	 data = env, pch = 16)

chisq.test(env$env_education, env$value_of_env_protection)
cor.test(env$env_education, env$value_of_env_protection, method = "spearman")



## fancy plot
tab = table(env)
tab = reshape2::melt(tab)
ggplot(tab) + geom_tile(aes(x = env_education, y = value_of_env_protection, fill = value)) + 
	scale_fill_viridis_c()

