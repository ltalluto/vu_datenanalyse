# remember to set your working directory if needed!
# setwd("unit_1")
t1_population = read.csv("data/w1t1.csv")
hist(t1_population$x, breaks=50, col="gray")

(N<-length(t1_population$x))
(mu<-mean(t1_population$x))

sd(t1_population$x) # this is for sample but we have population
(sigma<-sqrt(sum((t1_population$x-mu)^2)/N))

# SEM for n=25
sigma/sqrt(25)

n<-25
xbars<-rep(NA,1000)
for (i in 1:1000) {
  samp<-sample(t1_population$x,n)
  xbars[i]<-mean(samp)
}
hist(xbars,add=TRUE,col="red")
hist(xbars,add=TRUE,col="green")

samp<-sample(t1_population$x,n)
(xbar<-mean(samp))
(sd<-sd(samp))
(sem<-sd/(sqrt(n)))

# confidence interval
# xbar +/- z*SEM
qnorm(p=0.025)
aprec<-qnorm(p=0.975)*sigma/sqrt(25)
st_err<-sigma/sqrt(25)
xbar-aprec
xbar+aprec

my_stats = data.frame(name = "Gabriel", mean = xbar, sd = sd,
                      lower = xbar - 1.96*st_err, 
                      upper = xbar + 1.96*st_err)
my_stats

# xbar +/- t*SEM
aprec<-qt(p=0.975,df=n-1) * sem
xbar-aprec
xbar+aprec


## coral reef fish
fish <- read.csv("data/coral_fish.csv")
str(fish)
head(fish)

hist(fish$richness)
hist(fish$richness[fish$type=="tropical"])
hist(fish$richness[fish$type=="subtropical"])
boxplot(richness~type,data=fish)

fish
richness
fish$richness

mean(fish$richness[fish$type=="tropical"])
mean(fish$richness[fish$type=="subtropical"])

tapply(X=fish$richness,INDEX=fish$type,FUN=mean)
tapply(fish$richness,fish$type,mean)

?tapply
with(fish, tapply(richness,type,mean))

# 95% confidence intervals
xbar<-mean(fish$richness[fish$type=="subtropical"])
n<-length(fish$richness[fish$type=="subtropical"])
sem<-sd(fish$richness[fish$type=="subtropical"])/sqrt(n)
#xbar +/- t*sem
t<-qt(p=c(0.025,0.975),df=n-1)
ci<-xbar+t*sem
names(ci)<-c("lower","upper")
ci

#AIM: tapply(richness,type,ci_function)

# ci-function
conf_interval<- function (x,alpha=0.05) {
  xbar<-mean(x)
  n<-length(x)
  sem<-sd(x)/sqrt(n)
  #xbar +/- t*sem
  t<-qt(p=c(alpha/2,1-alpha/2),df=n-1)
  ci<-xbar+t*sem
  names(ci)<-c("lower","upper")
  return(ci)
}

conf_interval(x=fish$richness[fish$type=="subtropical"],alpha=0.1)

tapply(fish$richness,fish$type,conf_interval,alpha=0.1)

with(fish, tapply(richness,type,conf_interval,alpha=0.05))

# ttest
with(fish, tapply(richness,type,sd))
var.test(richness~type,data=fish)
# var. homogeneous!
# better: variances are not significantly different (F=0.59,df1=37,df2=175,P=0.07)

t.test(richness~type,data=fish,var.equal=TRUE)
?t.test
# Tropical and subtropical reefs differ significantly in
# mean fish richness (t=-4.9,df=212,P<0.001).
t.test(richness~type,data=fish,var.equal=TRUE,alternative="less")
levels(fish$type)


