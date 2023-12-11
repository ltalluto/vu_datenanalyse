# canonical correspondence analysis
# using a dataset available in the vegan package

library(vegan)
library(shape)

data(varespec)
data(varechem)
varespec
varechem
names(varespec)
?varespec
apply(varespec,1,sum) # approximate 100 (total cover)
# "absolute" abundance data

###########################
# canonical correspondence analysis #
vare.cca<-cca(Y=varespec,X=varechem) # note strange terminology of X and Y in vegan (don´t ask)
vare.cca<-cca(varespec~.,varechem) # hypothesis tests need formula interface (don´t ask)

summary(vare.cca,scaling=1)
summary(vare.cca,scaling=2)
# again two different types of scaling are possible for triplots

####################
# hypothesis tests #

# testing the first axis (global test)
anova(vare.cca)
anova(vare.cca,first=TRUE)

# testing all axes sequentially (preceding axes are taken as constraints)
anova(vare.cca,by="axis",model="direct",perm.max=9999,step=1000)

# testing the individual terms=constraints
anova(vare.cca,by="terms",model="direct",perm.max=9999,step=1000)  # tests terms sequentially, order matters!
anova(vare.cca,by="margin",model="direct",perm.max=9999,step=1000) # tests each term in full model (like drop1() function)

# quite a lot of variables in the constraining matrix, maybe selection would be adequate
# --> function ordistep(), also check out package {packfor}

###################
# making triplots #

# again various types of scaling for the plotting step:
# scaling 1 "distance triplot"
# sites can be projected on constraints
# sites close to centroid of factor constraint are more likely to possess the specific state (factor level)
# distances among sites reflect their Chi^2 distances

# scaling 2 "correlation triplot"
# species can be projected on constraints (to give their optimum)
# species close to centroid of factor constraint are more likely to be found in the respective sites
# distances among sites do not reflect their Chi^2 distances

# scaling 3 is compromise

plot(vare.cca,scaling=1,display=c("species","sites"))
plot(vare.cca,scaling=1,display=c("species","sites","bp"))
plot(vare.cca,scaling=2)
plot(vare.cca,scaling=3) # a compromise
# for any scaling take care when interpreting species close to origin:
# these are "everywhere" or have optimum right at the origin (i.e., optimum with regard to both axis shown)

# for more controlled plotting compute scores individually

(species<-scores(vare.cca,display="species",scaling=2))

(lcs<-scores(vare.cca,display="lc",scaling=2)) # fitted site scores

(sites<-scores(vare.cca,display="sites",scaling=2)) # unfitted site scores

(constraints<-scores(vare.cca,choices=c(1,2),display="bp",scaling=2))

plot(sites,col="black",pch=21,xlim=c(-2,2),ylim=c(-2,2))
text(species,col="red",label=names(varespec),cex=0.7)
Arrows(x0=0,y0=0,x1=constraints[,1],y1=constraints[,2],lwd=1.5,col="blue")
text(constraints[,1:2]*1.1,label=rownames(constraints),pos=4,cex=0.8,col="blue")


