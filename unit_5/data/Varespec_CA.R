# correspondence analysis
# using a dataset available in the vegan package
data(varespec)
data(varechem)
varespec
varechem
names(varespec)
?varespec
apply(varespec,1,sum) # approximate 100 (total cover)
# "absolute" abundance data

###########################
# correspondence analysis #
# run a CA just based on the species data (unconstrained!)
vare.ca<-cca(X=varespec) # function also used for CCA, but here only one matrix X is supplied

summary(vare.ca,scaling=1)
summary(vare.ca,scaling=2)
# again two different types of scaling are possible for biplots

# scaling 1 (distances among sites matter)
# sites are at the weighted centre of mass of species (rows are at centroids of columns)
# distances among sites approximate their chi^2 distance
# close sites have similar species abundances
# a site, which is near a specific species, has a high contribution of that species 

# scaling 2 (relationships among species matter)
# (columns at centroids of rows)
# distances among species approximate their chi^2 distance
# close species have similar abundances across sites
# a species, which is near a specific site, is more likely to be found at that site

plot(vare.ca,scaling=1)
plot(vare.ca,scaling=2)
plot(vare.ca,scaling=3) # a compromise
# for any scaling take care when interpreting species close to origin:
# these are "everywhere" or have optimum right at the origin (i.e., optimum with regard to both axis shown)

# for more controlled plotting
species.scores<-scores(vare.ca,display="species",scaling=2)
site.scores<-scores(vare.ca,display="sites",scaling=2)

plot(site.scores,col="black",pch=21,xlim=c(-2,2),ylim=c(-2,2))
text(species.scores,col="red",label=names(varespec),cex=0.7)

# post-hoc fitting of an environmental variable
names(varechem)
(ef<-envfit(vare.ca,varechem[,12:13],permutations=1999))
plot(ef)



