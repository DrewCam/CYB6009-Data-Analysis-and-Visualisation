# Data exploration and preparation.
# Goals:
# 1. Perform some basic exploratory data analysis.
# 2. Clean the file and prepare it for Machine Learning (ML).
# 3. Perform an initial Principal Component Analysis (PCA) of the data.
# 4. Identify features that may be useful for ML algorithms.
# 5. Create a brief report to the rest of the research team on your findings.

# You may need to change/include the path of your working directory
dat <- read.csv("MLData2023.csv", stringsAsFactors = TRUE)

# Separate samples of non-malicious and malicious events
dat.class0 <- dat %>% filter(Class == 0) # non-malicious
dat.class1 <- dat %>% filter(Class == 1) # malicious

# Randomly select 300 samples from each class, then combine them to form a working dataset
set.seed(Enter your student ID here)
rand.class0 <- dat.class0[sample(1:nrow(dat.class0), size = 300, replace = FALSE),]
rand.class1 <- dat.class1[sample(1:nrow(dat.class1), size = 300, replace = FALSE),]

# Your sub-sample of 600 observations
mydata <- rbind(rand.class0, rand.class1)

dim(mydata)  # Check the dimension of your sub-sample
