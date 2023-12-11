# data: Omengo et al, MSc-thesis Mara River, Kenya
# 54 streams draining catchments classified as "agricultural", "mixed" and "forested" based on GIS-data
# 49 variables describing the site properties, water chemistry (turbidity, nutrient concentrations, pH, etc.), DOM properies and carbon cycling

# RDA with DOM-properties as dependent matrix and TDN, canopy cover and stream size as constraints

library(shape) # just plots nice arrows and circles
library(vegan)

rm(list=ls(all=TRUE))

#############
# Read file #
data<-read.table(file="data/MaraRiver.txt",header=TRUE)

#########################################################
# get to know data and transform variables if necessary # 
names(data)
head(data)
str(data)
levels(data$landuse)

# a color vector for landuse
colors.landuse<-data$landuse
levels(colors.landuse)<-c("red","green","orange")
colors.landuse<-as.character(colors.landuse)

# DOM are variables 9:26
dom<-data[,27:46]

plot(dom) 
# -> note some skewed variables, log transform
dom$slope<-log(dom$slope)
dom$E2.to.E3<-log(dom$E2.to.E3)
dom$E4.to.E6<-log(dom$E4.to.E6)
dom$humF.to.protF<-log(dom$humF.to.protF)
dom$HIX<-log(dom$HIX)

plot(dom) 
boxplot(scale(dom))

rownames(dom)<-paste(data$landuse,seq(1:nrow(dom)),sep="_")

###############
# compute RDA #
# to z-standardize data (equal weight for all variables, note that the variables are dimensionally different)

zdom<-scale(dom) # must at least be centered even if dimensionally homogeneous!
xmat<-data.frame(logQ=log(data$Q),logTDN=log(data$TDN),canopy=data$canopy)

rda<-rda(zdom~logQ+logTDN+canopy,data=xmat) # take when using matrices X and Y --> X is dependent!

# actual RDA output check
summary(rda)
?cca.object
RsquareAdj(rda) # redundancy statistic (fractional amount of variation of the response data matrix explained by the constraints)

####################
# hypothesis tests #

# testing the first axis (global test)
anova(rda)
anova(rda,first=TRUE)

# testing all axes sequentially (preceding axes are taken as constraints)
anova(rda,by="axis",model="direct",perm.max=9999,step=1000)

# testing the individual terms=constraints
anova(rda,by="terms",model="direct",perm.max=9999,step=1000)  # tests terms sequentially, order matters!
anova(rda,by="margin",model="direct",perm.max=9999,step=1000) # tests each term in full model (like drop1() function)
# --> only log(TDN) is significant term


###################
# making triplots #

# again various types of scaling for the plotting step:
# scaling 1 "distance triplot"
# only angles between constraints and responses reflect their correlations (not angles among responses)
# distances among sites reflect their Euclidean distances

# scaling 2 "correlation triplot"
# all angles between constraints and responses reflect correlations 
# distances among sites do not reflect their Euclidean distances

# in both scaling types sites can be projected on constraints and on responses
# factor constraints are shown as centroids instead of arrows, projecting works identical 

# scaling 3 is compromise

# build an RDA scaling type 1 triplot
plot(rda,scaling=1)

(sites<-scores(rda,choices=c(1,2),display="sites",scaling=1)) 

(lcs<-scores(rda,choices=c(1,2),display="lc",scaling=1)) # fitted site scores ("linear constraints")

(species<-scores(rda,choices=c(1,2),display="sp",scaling=1)*.5)

(constraints<-scores(rda,choices=c(1,2),display="bp",scaling=1)*3)

plot(sites,asp=1,pch=21,bg=colors.landuse,ylim=c(-2.5,2.5))
Arrows(x0=0,y0=0,x1=constraints[,1],y1=constraints[,2],lwd=1.5,col="blue")
text(constraints[,1:2]*1.1,label=rownames(constraints),pos=4,cex=0.8,col="blue")

Arrows(x0=0,y0=0,x1=species[,1],y1=species[,2],lwd=1,arr.length=0)
text(species[,1:2]*1.1,label=rownames(species),pos=4,cex=0.6)

##############################
# some follow-up suggestions #
# include landuse as factor constraint



