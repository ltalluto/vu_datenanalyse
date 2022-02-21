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

# xbar +/- t*SEM
aprec<-qt(p=0.975,df=n-1) * sem
xbar-aprec
xbar+aprec

