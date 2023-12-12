# Microbial Stoichiometry

mic = read.table("data/MicrobesStoichiometry.txt", header = TRUE)
str(mic)

mic$NP = factor(mic$NP)

# subset dataset, I choose NP=5
mic = subset(mic, subset = (NP==5))
mic <- droplevels(mic)

# response should be the most reliable indicator for nucleic acids
names(mic)
plot(mic[,15:18])
boxplot(mic[,15:18])
zna<-scale(mic[,15:18])
mic$na.avg <- apply(zna,1,mean)
# this is an average na indicator where all 4 na-bands have same weight

# data is pseudoreplicated (multiple measurements per bottle)
# aggregation is needed, use means or medians for bottles
# checking distribution within each bottle
#...to choose proper statistic for aggregation
names(mic)
mic$all.treat<-factor(mic$all.treat)
levels(mic$all.treat)
levels(mic$all.treat)[1]
i<-1
hist(mic$na.avg[mic$all.treat==levels(mic$all.treat)[i]])
i<-i+1

# plot 32 histograms at once
layout(matrix(1:36,nrow=6,ncol=6))
old.par<-par # to keep graphical pars
par(mar=c(0,0,0,0))

for(i in 1:32) {
  hist(mic$na.avg[mic$all.treat==levels(mic$all.treat)[i]],
       main="",xaxt="n",yaxt="n",col="grey")
}
# choose median to aggregate data
na_bt_med<-tapply(mic$na.avg,INDEX=mic$all.treat,median)
species<-factor(substr(names(na_bt_med),start=0,stop=3))
phase<-factor(substr(names(na_bt_med),start=5,stop=7))
mic2<-data.frame(species,phase,na_bt_med)

# alternatively use aggregate()
mic = mic[, -2] # aggregation will make this factor meaningless
mic2 = aggregate(. ~ all.treat + species + phase + NP + bottle, data = mic, FUN = median)
levels(mic2$species)<-c("Pec","Ver")

# growth rate hypothesis: two-way ANOVA with factors species and growth phase
boxplot(na.avg~species,data=mic2)
boxplot(na.avg~phase,data=mic2)
boxplot(na.avg~species*phase,data=mic2)

# check variance homogeneity
combfac<-paste(mic2$species,mic2$phase,sep="_")
boxplot(na.avg~combfac,data=mic2)
bartlett.test(na.avg~combfac,data=mic2)
# variances cannot be identified as significantly different

# check ND (the fast way, could do this for each cell of design separately)
x<-unlist(tapply(mic2$na.avg,INDEX=combfac,scale))
hist(x)

# run 2-way ANOVA
fit<-aov(na.avg~species*phase,data=mic2)
summary(fit)
TukeyHSD(fit)

lm(na.avg~species,data=mic2)

# make a pointplot with means and sd as error, plus post-hoc results
means<-tapply(mic2$na.avg,combfac,mean)
sds<-tapply(mic2$na.avg,combfac,sd)
plot(means,xlim=c(0.7,4.3),ylim=c(-1,1.6),xlab="",
     ylab="nucleic acids",xaxt="n")
arrows( x0=c(1:4),y0=means-sds,x1=c(1:4),y1=means+sds,
        angle=90,code=3,length=0.1)
axis(1,at=c(1:4),labels=names(means))
text(c(1:4)+0.15,means,c("a","b","b","b"))

# resource use hypothesis: two-way ANOVA with factors species and resource stoichiometry

#### Hucho
hucho = read.table("data/HuchoRatschan2012.txt", header = TRUE)
names(hucho)
plot(hucho[,3:6])
plot(hucho$length~log(hucho$discharge))
plot(hucho$length~hucho$width)
head(hucho)

hucho$population<-factor(hucho$population,
                levels=c("large","medium","limited"))
col.pop<-hucho$population
levels(col.pop)<-c("green","orange","red")
col.pop<-as.character(col.pop)

#regression hypothesis
plot(length~log(discharge),data=hucho,col=col.pop)
m1<-lm(length~log(discharge),data=hucho)
#abline(m1)
summary(m1)

newdata<-data.frame(discharge=seq(min(hucho$discharge),
        max(hucho$discharge),length.out=100))
pm<-predict(m1,newdata=newdata,interval="conf",level=0.95)
lines(log(newdata$discharge),pm[,1])
lines(log(newdata$discharge),pm[,2])
lines(log(newdata$discharge),pm[,3])

# ANOVA hypothesis
boxplot(length~population,data=hucho,col=c("darkgreen","orange","red"))
summary(fit<-aov(length~population,data=hucho))
TukeyHSD(fit)

# ANCOVA
m2<-lm(length~population+log(discharge),data=hucho)
anova(m2)
summary(m2)

m3<-lm(length~population*log(discharge),data=hucho)
anova(m3)

plot(length~log(discharge),data=hucho,col=col.pop)
coef(m2)
abline(a=coef(m2)[1],b=coef(m2)[4],col="green")
abline(a=coef(m2)[1]+coef(m2)[2],b=coef(m2)[4],col="orange")
abline(a=coef(m2)[1]+coef(m2)[3],b=coef(m2)[4],col="red")
