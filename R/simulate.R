source("functions.R")

# These parameters are common to all simulations.

parameters = expand.grid(n = c(5, 30, 100),
                         theta0s = c(0, 0.2, 0.8),
                         taus = c(0.1, 0.5))

lower = 20
upper = 80
alpha = c(0, 0.025, 0.05, 1)
eta_ph = c(0.6, 0.3, 0.1)
eta_ps = c(1, 0.7, 0.1)

N = 100

### ============================================================================
### Actual simulation
### ============================================================================

FUN = function(parameter, type) {
  n = parameter[1]
  theta0 = parameter[2]
  tau = parameter[3]
  
  if(type == "pb") {
    eta = eta_ps
  } else {
    eta = eta_ph
  }
  
  estimates(N = N, n = n, lower = lower, upper = upper, theta0 = theta0, 
            tau = tau, alpha = alpha, eta = eta, type = type,
            chains = 1)
}

set.seed(313)
results_ph = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "ph")
results_pb = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "pb")
results_cl = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "cl")
saveRDS(results_ph, "../data/results_ph.Rds")
saveRDS(results_pb, "../data/results_pb.Rds")
saveRDS(results_cl, "../data/results_cl.Rds")
