pi = c(0.4, 0.2, 0.4)
alpha = c(0, 0.025, 0.05, 1)

cutoffs <- stats::qnorm(1 - alpha)
cdfs <- stats::pnorm(cutoffs)
diffs = rev(diff(rev(cdfs)))

pi = c(0.4, 0.2, 0.4)

pi_star = c(diffs[3] * 0.4, diffs[2] * (0.2 / 0.05 + 0.4), diffs[1] * (0.2 / 0.05 + 0.4 + 0.4/0.025))

alpha = c(0, 0.025, 0.05, 1)

f = function(rho) {
  a = c((pnorm(cutoffs[1]) - pnorm(cutoffs[2])) * rho[1],
        (pnorm(cutoffs[2]) - pnorm(cutoffs[3])) * rho[2],
        (pnorm(cutoffs[3]) - pnorm(cutoffs[4])) * rho[3])
  sum((a/sum(a) - pi_star)^2)
  
}

sol = nlm(f, runif(3))$estimate

sol/max(sol)

pi_ = function(rho) {
  a = c((pnorm(cutoffs[1]) - pnorm(cutoffs[2])) * rho[1],
        (pnorm(cutoffs[2]) - pnorm(cutoffs[3])) * rho[2],
        (pnorm(cutoffs[3]) - pnorm(cutoffs[4])) * rho[3])
  a/sum(a)
}

pi_(sol/max(sol))
