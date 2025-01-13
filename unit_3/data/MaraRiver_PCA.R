# data: Omengo et al, MSc-thesis Mara River, Kenya
# 54 streams draining catchments classified as "agricultural", "mixed" and "forested" based on GIS-data
# 49 variables describing the site properties, water chemistry (turbidity, nutrient concentrations, pH, etc.), DOM properies and carbon cycling

# start with PCA to simplify multivariate water chemistry dataset (reduce the number of dimensions)

library(shape) # just plots nice arrows and circles
library(vegan)

rm(list=ls(all=TRUE))

#############
# Read file #
data<-read.table(file="data/MaraRiver.txt",header=TRUE)

##################################################################
# get to know data and preselect cases or variables if necessary # 
names(data)
head(data)
str(data)
levels(data$landuse)

# a color vector for landuse
colors.landuse<-data$landuse
levels(colors.landuse)<-c("red","green","orange")
colors.landuse<-as.character(colors.landuse)

# water chemistry are variables 9:26
wc<-data[,9:26]

which(is.na(wc),arr.ind=TRUE)
# -> one stream has missing values for some variables, if variables should be kept, then this case must be deleted
wc<-wc[-6,]
data<-data[-6,]

# check potential for PCA by correlation plot
plot(wc) 
# -> note NH4 outlier, consider deletion
which(wc$TDN==max(wc$TDN))
data<-data[-5,] # delete the stream with max NH4 outlier (maybe repeat analysis without deletion and compare)
wc<-wc[-5,]

plot(wc) 
# -> note skewness in some variables, consider log(transform)
which(wc==0,arr.ind=TRUE) # check first if any zeros (log of 0 is not defined)
wc<-log(wc)
plot(wc) 
# -> some decent correlations between variables, no extreme skewness visible, good input for PCA


###############
# compute PCA #
# to z-standardize data (equal weight for all variables, note that the variables are dimensionally different)
zwc<-scale(wc,center=TRUE,scale=TRUE)

pca<-prcomp(zwc,retx=T,center=F,scale.=F)
pca<-prcomp(wc,retx=T,center=T,scale.=T)   # equivalent to line above

# check what output pca() delivers
?prcomp
pca$sdev # the standard deviations of the PCA axes (their squares are the eigenvalues)

pca$x # the site scores on all PCA-axes (the coordinates of observations in the ordination space defined by the PCs)
apply(pca$x,2,sd) # once again their standard deviations
scores<-pca$x

# the variable loadings (the coefficients of the linear combinations defining the PCs)
# here each column represents one PC as an additive linear combination of the coefficients given for each underlying variable 
pca$rotation 
zwc %*% pca$rotation # to manually compute scores from variables and loadings
loadings<-pca$rotation

summary(pca)

# diagnostics for percentage of variance explained (how many axes should be kept?)
# plots component number against variance represented by this component
screeplot(pca,npcs=length(pca$sdev),type = "lines")
# proportion of variance
pca.pct<-100*round(summary(pca)$importance[2,],3)          
barplot(pca.pct)
# -> the first 3-4 PCs seem useful, and just PC1 and PC2 alone are already explaining a lot of overall variance
# note also that eigenvalue of PC5 drops <1, so PC5 contributes less than one original variable (Kaiser-Guttman criterion)

###############
# PCA biplots #

# for a DISTANCE BIPLOT (focus is on sites, "scaling 1")
# each principal component has variance given by eigenvalue, loadings remain unscaled
plot(scores[,1:2],asp=1,pch=21,bg=colors.landuse)
arrows<-loadings*7 # with extension factor
plotcircle(r=7*sqrt(2/ncol(wc)),lcol="green") # circle of equilibrium contribution (equal contribution to all PCA-dimensions)
Arrows(x0=0,y0=0,x1=arrows[,1],y1=arrows[,2],col="darkgreen")
text(x=arrows[,1]*1.3,y=arrows[,2]*1.2,labels=names(wc),cex=0.7)
# arrows which reach out of the circle contribute more than on average

biplot(pca,scale=0)
# in this plot:
# 1) distances among sites are approximating true Euclidean distances in multivariate space
# 2) angles between arrows do not reflect correlations among variables
# 3) projecting site on descriptor at right angle gives its appr. descriptor value


# for a CORRELATION BIPLOT (focus is on variables, "scaling 2")
# each principal component is weighted by 1/sqrt(eigenvalue), so it has variance 1
var(scores[,1]/pca$sdev[1]) # just demo
plot(scores[,1]/pca$sdev[1],scores[,2]/pca$sdev[2],pch=21,bg=colors.landuse,asp=1)
# loadings are weighted by sqrt(eigenvalues) (multiplied by sqrt(eigenvalues))
arrows<-loadings*matrix(pca$sdev,nrow=nrow(loadings),ncol=ncol(loadings),byrow=TRUE)
arrows<-arrows*2 # choose extension factor
Arrows(x0=0,y0=0,x1=arrows[,1],y1=arrows[,2],col="purple")
# as alternative just compute correlation of scores with original data ("structure coefficients")
(structure<-cor(wc,scores))
structure<-2*structure
Arrows(x0=0,y0=0,x1=structure[,1],y1=structure[,2],col="red")

biplot(pca,scale=1)
# in this plot
# 1) distances among sites are not approximating true Euclidean distances in multivariate space
# 2) angles between arrows reflect correlations among variables (NOT proximity of arrow heads)
# 3) projecting site on descriptor at right angle gives its appr. descriptor value

# error in help page for biplot.princomp: observations are scaled by lambda^(0-scale)

# PCA using the rda function from the vegan package
pca2<-rda(X=wc,scale=TRUE)
summary(pca2,scaling=1)
scores(wc,scaling=0)
biplot(pca2,scaling=1)
biplot(pca2,scaling=2)
# note different scaling factors, but solution remains same


##############################
# some follow-up suggestions #
# do PCA for DOM properties
# test PCA-axes for effect of landuse or stream size (as log(Q)) using ANOVA or ANCOVA
# correlate PCA-axes with other potential "controlling" variables (e.g. TDN, canopy cover) to give "meta-dimensions" more meaning
# useful function envfit()



