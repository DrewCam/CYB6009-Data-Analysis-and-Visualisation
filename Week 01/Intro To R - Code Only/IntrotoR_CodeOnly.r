# De-comment the line below to install the relevant packages (if required)
#install.packages("tidyverse","timeDate")
library(tidyverse)

## ------------------------------------------------------------------------
x <- 35


## ------------------------------------------------------------------------
x


## ------------------------------------------------------------------------
x <- 18; x


## ------------------------------------------------------------------------
y <- x + 8; y   


## ------------------------------------------------------------------------
y <- 3*x+5; y


## ------------------------------------------------------------------------
diam <- 10  #diameter = 10 cm
radius <- diam/2  #radius is half of the diameter
area.circle <- pi*radius^2  #area of the circle


## ------------------------------------------------------------------------
"a"
"abc123"
"apples"
"I hate apples"


## ------------------------------------------------------------------------
"a"; "abc"; "apples"; "I hate apples"


## ------------------------------------------------------------------------
5.5; 2.75; pi


## ------------------------------------------------------------------------
5.5+2.7  #Addition
5.5-2.7  #Subtraction
5.5/2  #Division
5.5*2  #Multiplication
5.5^2  #Squaring
5.5^4  #To the power of 4
sqrt(5.5)  #Square root
exp(5.5)  #Exponential
log(5.5)  #Natural log


## ------------------------------------------------------------------------
5L  #5
-3L  #-3


## ------------------------------------------------------------------------
5==5  #Does 5 equal 5?
5==2  #Does 5 equal 2?
5!=2  #Does 5 not equal 2?;
5>2  #Is 5 greater than 2?
5>=2  #Is 5 greater than or equals to 2
5<2  #Is 5 less than 2?
5<=2  #Is 5 less than or equals to 2


## ------------------------------------------------------------------------
(5>2)&(5>4)
(5>2)&(5<4)
(5>2)|(5<4)


## ------------------------------------------------------------------------
c()  #A null vector
c(1,2,3)  #A numeric vector
c("a","b","c")  #A character vector
c(TRUE,FALSE,FALSE)  #A logical vector


## ------------------------------------------------------------------------
a <- c(1:5); a


## ------------------------------------------------------------------------
a[2]  #2nd element
a[3]  #3rd element
a[3:5]  #3rd to 5th element
a[c(2,5)]  #2nd and 5th elements


## ------------------------------------------------------------------------
b <- c(6:10); b  #Create a new vector b containing the integers 6, 7, 8, 9 and 10.
c <- c(a,b); c  #Combine vectors a and b, and assign the vector sum to a new vector, c.


## ------------------------------------------------------------------------
a*0.25  #Multiply the elements of vector a by a constant, i.e. 0.25
a+b  #Add the elements of vector a and vector b together
b-a  #Subtract the elements of vector a from vector b
a*b  #Multiply the elements of vector a and vector b together
b/a  #Divide the elements of vector b by the elements of vector a


## ------------------------------------------------------------------------
f1 <- c(1:5);  #A numeric vector
f1 <- factor(f1); f1  #Convert f1 to a factor

f2 <- c("Male","Female","Female","Male","Female");  #A charactor vector
f2 <- factor(f2); f2  #Convert f2 to a factor


## ------------------------------------------------------------------------
f3 <- factor(c("L","M","H","H","M","L")); f3


## ------------------------------------------------------------------------
#re-order the levels of f3 and overwrite the original f3.
f3 <- factor(f3,levels=c("L","M","H")); f3


## ------------------------------------------------------------------------
Mat.A <- matrix(c(1:9),nrow=3,ncol=3,byrow=FALSE); Mat.A


## ------------------------------------------------------------------------
Mat.B <- matrix(c(1:9),nrow=3,ncol=3,byrow=TRUE); Mat.B


## ------------------------------------------------------------------------
Mat.A <- matrix(c(1:9),  #9 entries to be read in
                nrow=3,  #3 rows
                ncol=3,  #3 columns
                byrow=FALSE  #data to be read in column-wise (default)
                ); 
Mat.A


## ------------------------------------------------------------------------
v1 <- c(1:3)  #Vector 1
v2 <- c(4:6)  #Vector 2
v3 <- c(7:9)  #Vector 3

Mat.A <- cbind(v1,v2,v3); Mat.A  #binding vectors as column vectors
Mat.B <- rbind(v1,v2,v3); Mat.B  #binding vectors as row vectors


## ------------------------------------------------------------------------
Mat.A*Mat.B


## ------------------------------------------------------------------------
Mat.A%*%Mat.B  #A matrix multiply B
Mat.B%*%Mat.A  #B matrix multiply A


## ------------------------------------------------------------------------
Mat.A[2,3]  #Access the element located in row 3 and column 3
Mat.A[1:2,3]  #Access the elements located in rows 1 and 2 along column 3
Mat.A[1,2:3]  #Access the elements located along row 1 and in columns 2 and 3
Mat.A[1,]  #Access all elements in row 1
Mat.A[,3]  #Access all elements in column 3
Mat.A[,c(1,3)]  #Access all elements in columns 1 and 3
Mat.A[,-1]  #Access all data, except those in column 1


## ------------------------------------------------------------------------
Name <- c("John","Sarah","Zach","Beth","Lachlan");  #Name - Character vector
Age <- c(35,28,33,55,43); #Age - Numeric vector
Gender <- factor(c("Male","Female","Male","Female","Male"));  #Gender - factor 


## ------------------------------------------------------------------------
df <- data.frame(Name,Age,Gender); df


## ------------------------------------------------------------------------
Coffee.Drinker <- c(TRUE,TRUE,FALSE,TRUE,FALSE);  #Drinks coffee? - logical vector

data.frame(df,Coffee.Drinker)  #Add new column to the data frame - Method 1
cbind(df,Coffee.Drinker)  ##Add new column to the data frame - Method 2


## ------------------------------------------------------------------------
df[1,c(1:3)]
df[2:3,]
df[,c(1,3)]


## ------------------------------------------------------------------------
df[,"Name"]
df[,c("Name","Gender")]


## ------------------------------------------------------------------------
df$Name  #Access and display the "Name" column
df$Age  #Access and display the "Age" column


## ------------------------------------------------------------------------
#Add the new variable, Coffee.Drinker, to df and recall the data frame
df$Coffee.Drinker <- c(TRUE,TRUE,FALSE,TRUE,FALSE); df  

#Add the new variable, Diabetes, to df and recall the data frame
df$Diabetes <- factor(c("Yes","No","No","No","Yes")); df  


## ------------------------------------------------------------------------
tib1 <- tibble(Name,Age,Gender,Coffee.Drinker); tib1


## ------------------------------------------------------------------------
str(df)


## ------------------------------------------------------------------------
as.data.frame(tib1)  #Convert the tibble, tib1, to a data frame
as_tibble(df)  #Convert the data frame, df, to a tibble


## ------------------------------------------------------------------------
list1 <- list(c,Mat.A,df); list1
str(list1)  #examine the structure of the list and its components.


## ------------------------------------------------------------------------
list1[[1]]  #Access the 1st component, i.e. vector c
list1[[2]]  #Access the 2nd component, i.e. matrix Mat.A
list1[[3]]  #Access the 3rd component, i.e. data frame df


## ------------------------------------------------------------------------
#Create the same list, but each component is labelled
list1 <- list(VecC=c,MatA=Mat.A,DatFrame=df)

str(list1)  #Examine the structure of the list


## ------------------------------------------------------------------------
list1$VecC  #Access the vector component
list1$MatA  #Access the matrix component
list1$DatFrame  #Access the data frame component


## ------------------------------------------------------------------------
c(1,"a")  #numeric value is coerced into a character 
c(TRUE,"a")  #logical value coerced into a character
c(TRUE,1)  #logical value is coerced into a numeric; 1 = TRUE, 0 = FALSE by default

#The 1st three elements are coerced into characters.
matrix(c(5,FALSE,4.6,"No"),nrow=2,ncol=2,byrow=FALSE)  

## ------------------------------------------------------------------------
#20 random numbers between 1 and 10 (inclusive)
x1 <- sample(1:10,size=20,replace=TRUE); x1  
#20 random numbers between 5 and 15 from a Uniform distributionn
x2 <- runif(20,5,15); x2  
#20 random numbers from a normal distribution with mean=12 and sd=3
x3 <- rnorm(20,mean=12,sd=3); x3 


## ------------------------------------------------------------------------
#A sequence from 1 to 20 with a 0.5 increment
x4 <- seq(1,20,by=0.5); x4
#Repeat the sequence {1,2,3,4,5} 5 times over
x5 <- rep(c(1:5),times=5); x5
#Repeat each element of the sequence {1,2,3,4,5} by 5 times
x6 <- rep(c(1:5),each=5); x6
#Repeat each element of the sequence {1,2,3,4,5} by 3 times, and then repeat 
#that sequence the 2nd time. Note that "each" has precedence over "times".
x7 <- rep(c(1:5),times=2,each=3); x7


## ------------------------------------------------------------------------
letters[1:10]	 #List first 10 letters (in lower case) of the alphabet
LETTERS[1:10]	 #List first 10 letters (in UPPER case) of the alphabet


## ----echo=FALSE,error=FALSE, out.width = "80%", fig.align='center', fig.cap='\\label{fig:fig4}Importing Data'----
knitr::include_graphics("Importing_Data.png")


## ---- echo=FALSE---------------------------------------------------------
#If using the 1st option
ElderlyPopWA <- read.csv("ElderlyPopWA.csv") 
View(ElderlyPopWA)

#If using the 2nd option
library(readr)
ElderlyPopWA <- read_csv("ElderlyPopWA.csv")  
View(ElderlyPopWA)


## ---- eval=FALSE---------------------------------------------------------
## #Method 1
## write.csv(ElderlyPopWA,  #Name of the data frame/tibble to be exported
##          "ElderlyPopWA_updated.csv"  #Name of the new CSV file to write the data to.
##          )
## 
## #Method 2
## write_csv(ElderlyPopWA,  #Name of the data frame/tibble to be exported
##          "ElderlyPopWA_updated.csv"  #Name of the new CSV file to write the data to.
##          )


## ----echo=FALSE,error=FALSE, out.width = "80%", fig.align='center', fig.cap='\\label{fig:fig5}BMI classification'----
knitr::include_graphics("BMI_Class.png")


## ------------------------------------------------------------------------
#Create BMI categories for the elderly female participants

mBMI <- max(ElderlyPopWA$BMI)  #maximum BMI value within the sample

ElderlyPopWA$BMI.class <- cut(ElderlyPopWA$BMI,
                              breaks=c(0,23,31,mBMI), #Set the intervals for the classes
                              labels=c("Underweight",
                                       "Healthy_Weight",
                                       "Overweight")) #Add labels to the classes


## ------------------------------------------------------------------------
#Subsetting by a categorical variable

#Underweight individuals only
Underweight <- subset(ElderlyPopWA,BMI.class=="Underweight"); 

#Under and overweight individuals
Unhealthy.weight <- subset(ElderlyPopWA,BMI.class=="Underweight"|BMI.class=="Overweight"); 

#Subsetting by a condition on a continuous variable
Age.LT75 <- subset(ElderlyPopWA,Age<75);  #Select those under 75 years of age.


## ------------------------------------------------------------------------
#Underweight individuals only
Underweight <- ElderlyPopWA[which(ElderlyPopWA$BMI.class=="Underweight"),]

#Select those under 75 years of age.
Age.LT75 <- ElderlyPopWA[which(ElderlyPopWA$Age<75),] 

#Select those that are not under 75 years of age.
Age.GTE75 <- ElderlyPopWA[-which(ElderlyPopWA$Age<75),]


## ------------------------------------------------------------------------
#Measures of centre
mean(ElderlyPopWA$Age)  #Mean (i.e. average) age
median(ElderlyPopWA$Age)  #Median age

#Measures of spread
sd(ElderlyPopWA$Age)  #Standard deviation of age
range(ElderlyPopWA$Age)  #range of age, i.e. minimum and maximum
IQR(ElderlyPopWA$Age)  #Interquartile range
fivenum(ElderlyPopWA$Age)  #Five-number summary, i.e. min, Q1, Q2, Q3, max.


## ------------------------------------------------------------------------
#install.packages("moments");  #De-comment to install the package
library(moments)  #Load the pacakge

#Measures of shape
skewness(ElderlyPopWA$Age)
kurtosis(ElderlyPopWA$Age)


## ------------------------------------------------------------------------
colMeans(data.frame(ElderlyPopWA[,2:8]))  # Column means


## ------------------------------------------------------------------------
apply(ElderlyPopWA[,2:8],  # Data
      MARGIN=2,  # Apply the function in a column-wise manner. MARGIN = 1 implies row-wise.
      FUN=mean  # The function to be applied.
      )


## ------------------------------------------------------------------------
apply(ElderlyPopWA[,2:8],  # Data
      MARGIN=2,  # Apply the function in a column-wise manner. MARGIN = 1 implies row-wise.
      FUN=sd  # The function to be applied.
      )


## ------------------------------------------------------------------------
BMI.freq <- table(ElderlyPopWA$BMI.class); BMI.freq  #Number of participants in each BMI class
BMI.prop <- prop.table(BMI.freq); BMI.prop  #Proportions of sample for each BMI class


## ------------------------------------------------------------------------
#Create another categorical variable, i.e. age group.
ElderlyPopWA$Age.grp <- cut(ElderlyPopWA$Age,c(0,74.99,100),
                            labels=c("<75years","75+years"))

#Cross tabulate age group with BMI
tab <- table(ElderlyPopWA$Age.grp,ElderlyPopWA$BMI.class); tab  #2 by 2 contigency table
prop.table(tab,1)  #Proportions by row, i.e. within each age group
prop.table(tab,2)  #Proportions by column, i.e. within each BMI class
tab/sum(tab)  #Proportions relative to overall sample size


## ------------------------------------------------------------------------
#Summarise the waist circumference of the individuals across the three BMI classes

#Compute the mean
aggregate(Waist~BMI.class,  #Formula to subset the Waist data by BMI classes
          data=ElderlyPopWA,  #Define the relevant data
          FUN=mean)  #Define the function to compute the desired statistic(s), i.e. mean

#Compute the standard deviation
aggregate(Waist~BMI.class,data=ElderlyPopWA,FUN=sd)


## ------------------------------------------------------------------------
#Summarise the waist circumference of individuals across all combinations between 
#BMI classes and age groups.

#Compute the mean
aggregate(Waist~BMI.class+Age.grp,data=ElderlyPopWA,FUN=mean)

#Compute the standard deviation
aggregate(Waist~BMI.class+Age.grp,data=ElderlyPopWA,FUN=sd)



## ---- warning=FALSE------------------------------------------------------
#Mean waist circumference by BMI class
tapply (ElderlyPopWA$Waist,
        INDEX=ElderlyPopWA$BMI.class,
        FUN=mean)

#Mean waist circumference by BMI class and age group
tapply (ElderlyPopWA$Waist,
        INDEX=list(ElderlyPopWA$BMI.class,ElderlyPopWA$Age.grp),
        FUN=mean)


## ------------------------------------------------------------------------
round(prop.table(table(ElderlyPopWA$BMI.class)),3) 

## ------------------------------------------------------------------------
BMI.freq <- table(ElderlyPopWA$BMI.class);  #Number of participants in each BMI class
BMI.prop <- prop.table(BMI.freq);  #Proportions of sample for each BMI class
round(BMI.prop,3)  #Display the proportions to 3 d.p.

## ------------------------------------------------------------------------
ElderlyPopWA$BMI.class %>%
  table(.) %>%
  prop.table(.) %>%
  round(.,digits=3)

## ------------------------------------------------------------------------
ElderlyPopWA$BMI.class %>%
  table() %>%
  prop.table() %>%
  round(digits=3)

## ------------------------------------------------------------------------
5 %>% round(pi,digits=.)

## ------------------------------------------------------------------------
Greeting <- function()
{
  print("Hello! My name is XXXX")
}

## ------------------------------------------------------------------------
Greeting()

## ------------------------------------------------------------------------
add3 <- function(x)
{
  x + 3
}

## ------------------------------------------------------------------------
add3(5)
add3(10)
add3(15)

## ------------------------------------------------------------------------
add_mult <- function(x,y)
{
  sum_xy <- x + y  #Calculate the sum of x and y
  prod_xy <- x * y  #Calculate the product of x and y
  ratio_xy <- x / y  #Calculate the ratio of x to y
}

## ------------------------------------------------------------------------
x <- 3; y <- 4;

add_mult(x,y) %>% #Call the function
  print()  #Print the value of the function

## ------------------------------------------------------------------------
add_mult <- function(x,y)
{
  sum_xy <- x + y  #Calculate the sum of x and y
  prod_xy <- x * y  #Calculate the product of x and y
  ratio_xy <- x / y  #Calculate the ratio of x to y
  
  c(sum_xy,prod_xy,ratio_xy) #A vector consisting of the sum, product and ratio
}

## ------------------------------------------------------------------------
add_mult(x=3,y=4)

## ------------------------------------------------------------------------
add_mult(y=4,x=3) 


## ------------------------------------------------------------------------
add_mult(3,4)

## ------------------------------------------------------------------------
x <- 5  # Set an arbitrary x value

#If statement
if (x%%2 != 0)
{
  cat(paste(x," is an odd integer\n",sep="")) #print command
}

## ------------------------------------------------------------------------
x <- 10  # Set an arbitrary x value

if (x%%2 != 0)
{
  cat(paste(x," is an odd integer\n",sep=""))
}else{
  cat(paste(x," is an even integer\n",sep=""))
}

## ------------------------------------------------------------------------
score <- 65  #Set an arbitrary score

if (score < 0)
{
  print("Invalid score!")  #Cannot have a negative score
}else if (score < 50){
  print("Your final grade is N.")
}else if (score <60){
  print("Your final grade is P.")
}else if (score <70){
  print("Your final grade is C.")
}else if (score <80){
  print("Your final grade is D.")
}else if (score <=100){
  print("Your final grade is HD.")
}else{
  print("Invalid score!") #Cannot have a score greater than 100%
}

## ------------------------------------------------------------------------
#For loop
for (I in 1:10)
{
  print(I)
}

## ------------------------------------------------------------------------
#Create a copy of ElderlyPopWA and store it as a data frame
dat <- data.frame(ElderlyPopWA)  

#For loop that starts at 2
for (J in 2:8)
{
  mean(dat[,J]) %>%  #Find the mean of the jth column
    print()  #Print the mean
}

## ------------------------------------------------------------------------
#For loop
for (I in 1:100)
{
  #If statement to check if the number is divisible by 7
  if (I%%7 == 0)
  {
    print(I)
  }
}

## ------------------------------------------------------------------------
count <- 0   #Set the count of numbers divisible by 13 to 0

for (I in 500:800)
{
  #1st if statement: Checks if the number is divisible by 13
  if (I%%13 == 0)  
  {
    print(I)  #Print the number
    count <- count + 1   #Add 1 to count
  }
  
  #2nd if statement: Checks if the count of numbers divisible by 13 is 10.
  #                  If so, break from the for loop
  if (count==10)  
  {
    break
  }
}
