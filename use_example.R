#############################################################################
##
#           Variable Selection for Fay-Herriot Models: A Cooperative Game Theory Approach
#
#                               Example of Use 
#
#
# Author: Esteban Cabello
# Date: 23/05/2025

### Simulating data 

library(sae)

data_example <- read.csv("Example.csv", header = T)

nvar <- 3 ## 3 explanatory variables


### We create a list with all possible combinations of variables.
### We have to use the 'coalitions' function of the TUvalues package (the order of the combinations is different from the natural one).

coal <- coalitions(nvar)
all_comb <- list()
for(j in 1:(length(coal[[2]])-1)){
  all_comb[[j]] <- as.numeric(unlist(strsplit(coal[[2]][j+1], ",")))
}

### We create a list with the formulas to be used for each model.
comb_var <- lapply(all_comb, function(x) x <- as.data.frame(xd[,x]))
comb_form_var <- lapply(comb_var, function(x) x <- as.formula(paste("yd ~ 0 +", paste(colnames(x), collapse= "+"))))

### Models with only one variable do not capture the name well.
for(j in 1:nvar){
  comb_form_var[[j]] <- as.formula(paste("yd ~ 0 +",colnames(xd)[j]))
}




### We compute the model with all the explanatory variables
full.model <- eblupFH(yd ~ 0 + X1 + X2 + X3 , vardir = sigma2d, data = datos)
full.model


KIC <- rep(0, length(comb_var)) ## Create a empty list to save the KIC for each model.

for(i in seq_along(comb_var)){
  
  model.i <- eblupFH(formula = comb_form_var[[i]], vardir = sigma2d, method = "ML", B = 200, data = datos) ## Fit the model
  
  KIC[i] <- model.i$fit$goodness[4] ## Save the KIC estimator
    
  
}

shapley_exact(KIC, nvar) ### Obtain the Shapley Value


#### Compute the nested models according to Shapley Value importance

modelX2 <- eblupFH(yd ~ 0 + X1 , vardir = sigma2d, data = datos)
modelX2$fit$goodness
modelX2$fit$estcoef[,4]

modelX21 <- eblupFH(yd ~ 0 + X1 + X2, vardir = sigma2d, data = datos)
modelX21$fit$goodness
modelX21$fit$estcoef[,4]

modelX213 <- eblupFH(yd ~ 0 + X1 + X2 + X3, vardir = sigma2d, data = datos)
modelX213$fit$goodness
modelX213$fit$estcoef[,4]

