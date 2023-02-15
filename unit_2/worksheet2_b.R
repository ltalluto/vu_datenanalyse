hydrop = read.table("data/Hydropsyche.txt", header = TRUE)

mod1 = lm(weight ~ width, data = hydrop)

# use the summary function to get information from your model
# how do you interpret the output?
summary(mod1)
par(mfrow = c(2,2), mar = c(2.5, 2.5, 1, 0.5), mgp = c(1.5, 0.5, 0))
plot(mod1)


par(mfrow = c(1,1))
plot(weight ~ width, data = hydrop, pch = 16)
abline(mod1, col = 'cyan', lwd = 2)

mod2 = lm(log(weight) ~ log(width), data = hydrop)
summary(mod2)
ggplot(hydrop, aes(x = width, y = weight)) + geom_point() + 
	geom_smooth(method = "glm", formula = y ~ log(x), 
				method.args = list(family = gaussian(link = "log")))
