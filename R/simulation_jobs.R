source("R/functions.R")

options(mc.cores = 3)
# These parameters are common to all simulations.

# The class variable says which simulation is being run.
#class = ""
#class = "uniform_"
class = "inv_gamma_"


parameters = expand.grid(
  n = c(5, 30, 100),
  theta0s = c(0, 0.2, 0.8),
  taus = c(0.1, 0.5))

parameters = cbind(parameters, i = seq(nrow(parameters)))

lower = 20
upper = 80
alpha = c(0, 0.025, 0.05, 1)
eta_ph = c(0.6, 0.3, 0.1)
eta_ps = c(1, 0.7, 0.1)



# Simulation function

FUN = function(parameter, type) {
  n = parameter[1]
  theta0 = parameter[2]
  tau = parameter[3]
  j = parameter[4]
  
  if(type == "pb") {
    eta = eta_ps
  } else {
    eta = eta_ph
  }
  
  sapply(1:N, function(i) {
    
    tictoc::tic
    
    result = estimate(
      n = n, 
      lower = lower, 
      upper = upper, 
      theta0 = theta0, 
      tau = tau, 
      alpha = alpha, 
      eta = eta,
      type = type,
      chains = 1,
      refresh = 0
    )
    
    tictoc::toc(log = TRUE, quiet = TRUE)
    msg = tictoc::tic.log(format = TRUE)[[1]]
    tictoc::tic.clearlog()
    cat(paste0("Iteration ", type, "-", j, "-", i, ": ", msg, "\n"))
    result
    
  })
  
}

# Using different types of simulations.

if(class == "") {
  
  N = 1000/5
  
} else if (class == "uniform_") {
  
  N = 100/5
  tau_prior = "uniform"
  prior = list(u_min = 0, u_max = 3)
  
} else if (class == "inv_gamma_") {
  
  N = 100/5
  tau_prior = "inv_gamma"
  prior = list(shape = 2, scale = 1/2)
  
}

# The simulation is divided into five jobs.

rstudioapi::jobRunScript(
  path = "R/job_scripts/simulate_5.R",
  workingDir = getwd(),
  name = "Simulation, part  5",
  exportEnv = "R_GlobalEnv")

rstudioapi::jobRunScript(
  path = "R/job_scripts/simulate_4.R",
  workingDir = getwd(),
  name = "Simulation, part  4",
  exportEnv = "R_GlobalEnv")

rstudioapi::jobRunScript(
  path = "R/job_scripts/simulate_3.R",
  workingDir = getwd(),
  name = "Simulation, part 3",
  exportEnv = "R_GlobalEnv")

rstudioapi::jobRunScript(
  path = "R/job_scripts/simulate_2.R",
  workingDir = getwd(),
  name = "Simulation, part  2",
  exportEnv = "R_GlobalEnv")

rstudioapi::jobRunScript(
  path = "R/job_scripts/simulate_1.R",
  workingDir = getwd(),
  name = "Simulation, part  1",
  exportEnv = "R_GlobalEnv")


for (type in c("ph", "pb", "cl")) {
  
  args = lapply(seq(1, 5), function(i) 
    parse(text = paste0("results_", type, "_", i))[[1]])
  
  results = do.call(rbind, args)
  
  k = nrow(results) # Number of simulated estimaes.
  n_type = 3 # Number of types estimated (ph, pb, cl)
  n_estimates = 2 # Number of estimates (mu, tau)
  
  table_mean = sapply(seq(1, n_type * n_estimates), function(i) {
    temp = results[seq(i, k, by = 6), ]
    colMeans(temp)
  })
  
  table_sd = sapply(seq(1, n_type * n_estimates), function(i) {
    temp = results[seq(i, k, by = 6), ]
    apply(temp, 2, sd)
  })
  
  table_total = t(cbind(table_mean, table_sd))
  
  name = paste0("data/results_", class, type, ".Rds")
  
  saveRDS(table_total, name)
  
}






