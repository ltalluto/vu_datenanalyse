lakes = read.table("data/LakeSPM.txt", header=TRUE)

# H1: Productive lakes support phytoplankton growth, thus higher spm.
# H2: Shallow lakes allow resuspension, thus higher spm.

par(mfrow = c(1,2), mar = c(2.5, 2.5, 1, 0.5), mgp = c(1.5, 0.5, 0), pch = 16)
plot(spm ~ Dm, data = lakes, xlab = "Mean Depth (m)", ylab = "[SPM]")
plot(spm ~ TP, data = lakes, xlab = "[Total Phosphorous]", ylab = "[SPM]")

plot(log(spm) ~ log(Dm), data = lakes, xlab = "log[Mean Depth (m)]", ylab = "log([SPM])")
plot(log(spm) ~ log(TP), data = lakes, xlab = "log([Total Phosphorous])", ylab = "log([SPM])")

# save one of these for later
m_simple = lm(log(spm) ~ log(TP), data = lakes)

# drop the first two columns
lakes = lakes[,-c(1, 2)]
plot(lakes, pch=16, cex = 0.5) # skewness issues!

# Note: not recommended to place *different variables* on the same scale!
boxplot(lakes)
boxplot(scale(lakes))

# better!
par(mfrow = c(2, 5))
for(i in 1:ncol(lakes))
	hist(lakes[,i], main = "", xlab = colnames(lakes)[i])

# more exploration - look for correlations
round(cor(lakes), 3)

# log tranform everything except pH and Dm
lakes[, -c(5,10)] = log(lakes[, -c(5,10)])
plot(lakes)

par(mfrow = c(2, 5))
for(i in 1:ncol(lakes))
	hist(lakes[,i], main = "", xlab = colnames(lakes)[i])
cor(lakes)


# fit a full model
# dot (.) makes a model with all predictors 
mlr.full = lm(spm ~ ., data = lakes) 
summary(mlr.full)
library(car)
vif(mlr.full) #computes VIF

# look at how area is predicted by the X matrix
# R^2 is one!
summary(lm(area ~ . - spm, data = lakes))


# try models dropping the worst terms
# minus removes a predictor from the model
vif(lm(spm ~ . - area, data = lakes))
vif(lm(spm ~ . - area - Dm, data = lakes))
vif(lm(spm ~ . - area - Dm - Dmax, data = lakes))

# we could look at the names to figure out which columns to drop
names(lakes)

# or we can do this with code ;-)
(drop = which(names(lakes) %in% c("area", "Dm", "Dmax")))
lakes = lakes[,-drop]

# for step, we define a starting model
m_full = lm(spm ~ ., data = lakes)
summary(m_full)
mod_step = step(m_full, direction = "both")
summary(mod_step)




## two competing models
# mod_simple and mod_step
# let's challenge them
# mod_fill: spm ~ .
# mod_step: spm ~ pH + TP + DR + Vd

n = nrow(lakes)
# create empty vectors to store predicted cases
preds_1 = numeric(n)
preds_2 = numeric(n)
# loop over every data point
for(i in 1:n) {
	# drop data point i
	lakes_sm = lakes[-i, ]
	
	# fit the models
	m1 = lm(spm ~ ., data = lakes_sm)
	m2 = lm(spm ~ pH + TP + DR + Vd, data = lakes_sm)
		
	# use the predict() function to get a model prediction
	# see ?predict.lm for clues
	preds_1[i] = predict(m1, newdata = lakes[i,])
	preds_2[i] = predict(m2, newdata = lakes[i,])
}

# compute the root mean square error
sq_err_1 = (preds_1 - lakes$spm)^2
sq_err_2 = (preds_2 - lakes$spm)^2

sqrt(mean(sq_err_1))
sqrt(mean(sq_err_2))
