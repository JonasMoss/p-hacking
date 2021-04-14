#' Generate sigmas uniformly
#' 
#' @param n Number of sigmas to generate.
#' @param lower Lower limit.
#' @param upper Upper limit.
#' @return n sigmas sampled uniformly with replacement.

sigma_generator = function(n, lower = 20, upper = 80) {
  1/sqrt(sample(x = lower:upper, size = n, replace = TRUE))
}

#' Simulate meta-analysis from the publication bias model.
#' 
#' @param n Number of sigmas to generate.
#' @param lower Lower limit.
#' @param upper Upper limit.
#' @param theta0 Effect size mean theta0
#' @param tau Standard deviation of effect size distribution
#' @param alpha Vector of cuttoffs
#' @param eta Vector of selection probabilities.
#' @return list of yi and vi.

simulate_pb = function(n, lower, upper, theta0, tau, alpha, eta) {
  
  sigma = sigma_generator(n, lower, upper)
  
  yi = publipha::rmpsnorm(n = n, 
                          theta0 = theta0, 
                          sigma = sigma,
                          tau = tau,
                          alpha = alpha, 
                          eta = eta)
      
  list(yi = yi, vi = sigma^2)
  
}

#' Simulate meta-analysis from the p-hacking model.
#' 
#' @param n Number of sigmas to generate.
#' @param lower Lower limit.
#' @param upper Upper limit.
#' @param theta0 Effect size mean theta0
#' @param tau Standard deviation of effect size distribution
#' @param alpha Vector of cuttoffs
#' @param eta p-hacking probabilties.
#' @return list of yi and vi.

simulate_ph = function(n, lower, upper, theta0, tau, alpha, eta) {
  
  sigma = sigma_generator(n, lower, upper)
  
  theta = rnorm(n, theta0, tau)
  
  yi = publipha::rphnorm(n = n, 
                         theta = theta, 
                         sigma = sigma,
                         alpha = alpha, 
                         eta = eta)
  
  list(yi = yi, vi = sigma^2)
  
}


#' Simulate meta-analysis from the classical model.
#' 
#' @param n Number of sigmas to generate.
#' @param lower Lower limit.
#' @param upper Upper limit.
#' @param theta0 Effect size mean theta0
#' @param tau Standard deviation of effect size distribution
#' @return list of yi and vi.

simulate_classical = function(n, lower, upper, theta0, tau) {
  
  sigma = sigma_generator(n, lower, upper)
  
  yi = rnorm(n = n, mean = theta0, sd = sqrt(sigma^2 + tau^2))
  
  list(yi = yi, vi = sigma^2)
  
}


#' Simulate one meta-analysis and estimate p-hacking and publication bias models.
#' 
#' @param n Number of sigmas to generate.
#' @param lower Lower limit.
#' @param upper Upper limit.
#' @param theta0 Effect size mean theta0
#' @param tau Standard deviation of effect size distribution
#' @param alpha Vector of cuttoffs
#' @param eta p-hacking probabilties.
#' @param type Type of data to simulate. "ph", "pb" or "classical".
#' @param ... Passed to publipha::ma.
#' @return list of yi and vi.

estimate = function(n, lower, upper, theta0, tau, 
                    alpha = NULL, eta = NULL, type = "pb", ...) {
  if(type == "pb") {
    data = simulate_pb(n, lower, upper, theta0, tau, alpha, eta) 
  } else if (type == "ph") {
    data = simulate_ph(n, lower, upper, theta0, tau, alpha, eta) 
  } else {
    data = simulate_classical(n, lower, upper, theta0, tau) 
  }
  
  model_ph = publipha::phma(yi, vi, data = data, ...)
  model_pb = publipha::psma(yi, vi, data = data, ...)
  model_cl = publipha::cma(yi, vi, data = data, ...)
  
  c(ph_theta0_mean = publipha::extract_theta0(model_ph),
    ph_tau_mean = publipha::extract_tau(model_ph),
    pb_theta0_mean = publipha::extract_theta0(model_pb),
    pb_tau_mean = publipha::extract_tau(model_pb),
    cl_theta0_mean = publipha::extract_theta0(model_cl),
    cl_tau_mean = publipha::extract_tau(model_cl))

}

#' Simulate one meta-analysis and estimate p-hacking and publication bias models.
#' 
#' @param N Number of simulations.
#' @param n Number of sigmas to generate.
#' @param lower Lower limit.
#' @param upper Upper limit.
#' @param theta0 Effect size mean theta0
#' @param tau Standard deviation of effect size distribution
#' @param alpha Vector of cuttoffs
#' @param eta p-hacking probabilties.
#' @param type Type of data to simulate. "ph", "pb" or "classical".
#' @param ... Passed to publipha::ma.
#' @return list of yi and vi.


estimates = function(N, n, lower, upper, theta0, tau, 
                    alpha = NULL, eta = NULL, type = "pb", ...) {
  
  values = replicate(N, estimate(n = n, 
                                 lower = lower, 
                                 upper = upper, 
                                 theta0 = theta0, 
                                 tau = tau, 
                                 alpha = alpha, 
                                 eta = eta,
                                 type = type,
                                 control = list(max_treedepth = 10,
                                                adapt_delta = 0.99),
                                 chains = 1))
  
  cbind(mean = rowMeans(values),
        sd = apply(values, 1, sd))
  
}
