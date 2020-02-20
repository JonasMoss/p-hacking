### ============================================================================
### This files estimates the two examples in the paper and saves the estimated 
### models in the data folder.
### ============================================================================

library("publipha")
n_chains = 8
alpha = c(0, 0.025, 0.05, 1)

### ============================================================================
### Anderson example.
### ============================================================================

seed = 313
## Define data sets.
anderson = dplyr::filter(dat.anderson2010, outcome == "AggBeh", 
                         experimental == TRUE, yi < 1)
anderson_best = dplyr::filter(anderson, best == TRUE)
anderson_worst = dplyr::filter(anderson, best == FALSE)

## Run the models.
set.seed(seed)
ma_anderson_all = allma(yi = yi, 
                        vi = vi, 
                        data = anderson, 
                        alpha = alpha, 
                        chains = n_chains,
                        control = list(adapt_delta = 0.9999))

set.seed(seed)
ma_anderson_best = allma(yi = yi, 
                         vi = vi, 
                         data = anderson_best, 
                         alpha = alpha, 
                         chains = n_chains,
                         control = list(adapt_delta = 0.9999))

set.seed(seed)
ma_anderson_worst = allma(yi = yi, 
                          vi = vi, 
                          data = anderson_worst, 
                          alpha = alpha, 
                          chains = n_chains,
                          control = list(adapt_delta = 0.9999))

## Make the loos.
loo_anderson_all = lapply(ma_anderson_all,loo)
loo_anderson_all_means = lapply(loo_anderson_all, 
                                function(x) x$estimates[3, 1])[c(3, 1, 2)]
loo_anderson_all_sds = lapply(loo_anderson_all, 
                              function(x) x$estimates[3, 2])[c(3, 1, 2)]

loo_anderson_best = lapply(ma_anderson_best,loo)
loo_anderson_best_means = sapply(loo_anderson_best, 
                                  function(x) x$estimates[3, 1])[c(3, 1, 2)]
loo_anderson_best_sds = sapply(loo_anderson_best, 
                                function(x) x$estimates[3, 2])[c(3, 1, 2)]

loo_anderson_worst = lapply(ma_anderson_worst,loo)
loo_anderson_worst_means = sapply(loo_anderson_worst, 
                                  function(x) x$estimates[3, 1])[c(3, 1, 2)]
loo_anderson_worst_sds = sapply(loo_anderson_worst, 
                                function(x) x$estimates[3, 2])[c(3, 1, 2)]

### ============================================================================
### Cuddy example.
### ============================================================================

seed = 313

## Run the models.
set.seed(seed)
ma_cuddy2018 = allma(yi = yi, 
                     vi = vi, 
                     data = dat.cuddy2018, 
                     alpha = alpha, 
                     chains = n_chains,
                     control = list(adapt_delta = 0.9999))

set.seed(seed)
ma_cuddy2018_no = allma(yi = yi, 
                        vi = vi, 
                        data = dplyr::filter(dat.cuddy2018, yi < 1.5), 
                        alpha = alpha,
                        chains = n_chains,
                        control = list(adapt_delta = 0.9999))

## Make the loos.
loo_cuddy = lapply(ma_cuddy2018,loo)
loo_cuddy_means = lapply(loo_cuddy, function(x) x$estimates[3, 1])[c(3, 1, 2)]
loo_cuddy_sds = lapply(loo_cuddy, function(x) x$estimates[3, 2])[c(3, 1, 2)]

loo_no = lapply(ma_cuddy2018_no,loo)
loo_no_means = lapply(loo_no, function(x) x$estimates[3, 1])[c(3, 1, 2)]
loo_no_sds = lapply(loo_no, function(x) x$estimates[3, 2])[c(3, 1, 2)]
