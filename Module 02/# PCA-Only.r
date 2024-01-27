# PCA-Only.R

## ---------------------------------------------------------------------
#De-comment to install the packages below
#install.packages(c("vegan","tidyverse","timeDate","scales","scatterplot3d",
#"mlbench","mvabund","ggpubr","factoextra"))
library(vegan) #PCoA and distance/similarity matrices
library(scatterplot3d) #3-D plot
library(mlbench)  #Cancer dataset
library(mvabund)  #Spider dataset
library(scales) #For more graphic scales options
library(tidyverse)
library(ggpubr)
library(factoextra)


## ---------------------------------------------------------------------
data(iris)  #Load the dataset
#Rename the Species
iris$Species <- factor(iris$Species,
                       labels=c("Setosa","Versicolor","Virginica")) 


## ---------------------------------------------------------------------
#Scatter plot matrix
pairs(iris[,1:4],
      pch=23, #Shape of the points
      #Colour of the outline of the points
      col=as.numeric(iris$Species)+1,  
      #Fill colour of the points with reduced colour intensity
      bg=alpha(as.numeric(iris$Species)+1,0.4), 
      cex=1.5,  #Size of the points
      upper.panel=NULL,  #Do not display the the upper panel
      #Substitution the full stop in the feature names with a space
      labels=gsub("[[:punct:]]"," ",colnames(iris[,1:4])))  


## ---------------------------------------------------------------------
#PCA
pca.iris <- prcomp(iris[,1:4], #iris dataset excluding the Species column
                   scale = TRUE) #Standardised the data


## ---------------------------------------------------------------------
#Show the individual and cumulative proportion of variance explained.
summary(pca.iris) 


## ---------------------------------------------------------------------
pca.iris$rotation 


## ---------------------------------------------------------------------
plot(pca.iris, type = "l", main = "Scree plot - Iris")


## ---------------------------------------------------------------------
#Extract the eigenvalues and proportions explained
varexp.iris <- summary(pca.iris)$importance; varexp.iris

#Create the data frame for plotting
df <- data.frame(Variance = varexp.iris[1,]^2, PC = 1:length(pca.iris$sdev));

ggplot(df, aes(PC,Variance))+
  geom_line(colour = "steelblue", linewidth = 1.5, linetype = 2)+
  geom_point(size = 5)+
  theme_minimal(base_size = 14)+
  xlab("Principal Component")+
  ylab("Variance")+
  scale_x_discrete(limits = paste("PC",1:length(pca.iris$sdev), sep = ""))+
  annotate("text",x = c(1:4)+0.15, y = varexp.iris[1,]^2+0.3,
           label = paste(round(varexp.iris[2,]*100,1), "%",sep = ""))


## ---------------------------------------------------------------------
df <- data.frame(pca.iris$x,  #PCA scores
                 Species = iris$Species);

ggplot(df,aes(x=PC1,y=PC2))+
       geom_point(aes(colour=Species),alpha=0.8,size=4)+
       theme_minimal(base_size=14)+
       theme(legend.position = "top")+
       xlab("PC1")+
       ylab("PC2");


## ---------------------------------------------------------------------
#3D plot
scatterplot3d(pca.iris$x[,1:3],pch=21,
              color=as.numeric(iris$Species)+1,
              bg=alpha(as.numeric(iris$Species)+1,0.4),                  
              cex.symbols=2,
              col.grid="steelblue",
              col.axis="steelblue",
              angle=70);


## ---------------------------------------------------------------------
fviz_pca_biplot(pca.iris,
                axes = c(1,2),  #Specifying the PCs to be plotted. 
                #Parameters for samples
                col.ind=iris$Species,  #Outline colour of the shape
                fill.ind=iris$Species,  #fill colour of the shape
                alpha=0.5,  #transparency of the fill colour
                pointsize=4,  #Size of the shape
                pointshape=21,  #Type of Shape
                #Parameter for variables
                col.var="red",  #Colour of the variable labels
                label="var",  #Show the labels for the variables only
                repel=TRUE,  #Avoid label overplotting
                addEllipses=TRUE,  #Add ellipses to the plot
                legend.title=list(colour="Species",fill="Species",alpha="Species"))