# This function is used to avoid cluttering the environment when plotting.
.H = function(expr) rlang::new_function(alist(), substitute(expr))()

### ============================================================================
### Anderson example
### ============================================================================

.H({
jpeg("plots/anderson2010.jpg", 
     width = 8, height = 8, units = 'in', res = 300,
     quality = 100)

par(mar = par("mar") + c(0, 0, 0, 1))
z = seq(0, 1000, by = 0.1)
par(las = 1)
plot(x = 1/anderson$vi, 
     y = anderson$yi,
     log = "x",
     xlab = "Precision, log scale", ylab = "Estimated effect size",
     pch = anderson$best*19)
lines(x = z,
      y = 1.96*sqrt(1/z), lty = 3)
lines(x = z,
      y = 1.64*sqrt(1/z), lty = 2)


abline(h = publipha::extract_theta0(ma_anderson_best$cma), lwd = 1, col = "grey")
abline(h = publipha::extract_theta0(ma_anderson_worst$cma), lwd = 1, col = "grey")
ticks = c(publipha::extract_theta0(ma_anderson_best$cma),
          publipha::extract_theta0(ma_anderson_worst$cma))
axis(side = 4, at = ticks, labels = round(ticks, 2))
dev.off()  
})

# Posterior for theta

.H({
jpeg("plots/anderson_posterior.jpg", 
     width = 8, height = 8, units = 'in', res = 300,
     quality = 100)

plot(density(extract_theta0(ma_anderson_all$cma, identity), adjust = 3),
     ylim = c(0, 16), xlim = c(-0.1, .5), lwd = 2, xlab = expression(theta[0]),
     main = NA)
lines(density((extract_theta0(ma_anderson_all$psma, identity)), adjust = 3),
      lty = 3, lwd = 2)
lines(density((extract_theta0(ma_anderson_all$phma, identity)), adjust = 3), 
      lty = 2, lwd = 2)
dev.off()  
})

# Comparison of posteriors.

.H({
jpeg("plots/anderson_posterior_1.jpg", 
     width = 8, height = 8, units = 'in', res = 300,
     quality = 100)

plot(density(extract_theta0(ma_anderson_all$psma, identity), adjust = 3),
     ylim = c(0, 15), xlim = c(-0.5, .5), lwd = 2, main = NA,
     xlab = expression(theta[0]))
lines(density((extract_theta0(ma_anderson_best$psma, identity)), adjust = 3),
      lty = 3, lwd = 2)
lines(density((extract_theta0(ma_anderson_worst$psma, identity)), adjust = 3), 
      lty = 2, lwd = 2)

dev.off()  
})

.H({
jpeg("plots/anderson_posterior_2.jpg", 
     width = 8, height = 8, units = 'in', res = 300,
     quality = 100)

plot(density(extract_theta0(ma_anderson_all$cma, identity), adjust = 3),
     ylim = c(0, 15), xlim = c(-0.1, .5), lwd = 2, main = NA,
     xlab = expression(theta[0]))
lines(density((extract_theta0(ma_anderson_best$cma, identity)), adjust = 3),
      lty = 3, lwd = 2)
lines(density((extract_theta0(ma_anderson_worst$cma, identity)), adjust = 3), 
      lty = 2, lwd = 2)

dev.off()  
})

### ============================================================================
### Cuddy example.
### ============================================================================

.H({
   jpeg("plots/cuddy2018.jpg", 
        width = 8, height = 8, units = 'in', res = 300,
        quality = 100)
   par(mar = par("mar") + c(0, 0, 0, 1))
   z = seq(0, 1000, by = 0.1)
   par(las = 1)
   plot(x = 1/dat.cuddy2018$vi, 
        y = dat.cuddy2018$yi,
        pch = 19, log = "x", 
        ylim = c(-0.1, 1.7),
        xlab = "Precision, log scale", 
        ylab = "Estimated effect size")
   lines(x = z, y = 1.96*sqrt(1/z), lty = 3)
   lines(x = z, y = 1.64*sqrt(1/z), lty = 2)
   abline(h = publipha::extract_theta0(ma_cuddy2018$cma), lwd = 1, col = "grey")
   abline(h = publipha::extract_theta0(ma_cuddy2018$psma), lwd = 1, col = "grey")
   abline(h = publipha::extract_theta0(ma_cuddy2018$phma), lwd = 1, col = "grey")
   
   ticks = c(publipha::extract_theta0(ma_cuddy2018$cma),
             publipha::extract_theta0(ma_cuddy2018$psma),
             publipha::extract_theta0(ma_cuddy2018$phma))
   
   axis(side = 4, at = ticks, labels = round(ticks, 2))
   
   dev.off()  
})


# Posterior for theta

.H({
jpeg("plots/cuddy2018_posterior.jpg", 
     width = 8, height = 8, units = 'in', res = 300,
     quality = 100)
index = 2
plot(density(extract_theta(ma_cuddy2018$cma, identity, i = index), adjust = 2), 
     xlim = c(-1.3, 1.3),
     main = NA, sub = NA, xlab = "Effect Size", "Density",
     lwd = 2,
     lty = 1)
lines(density(extract_theta(ma_cuddy2018$phma, identity, i = index), adjust = 2),
      lwd = 2,
      lty = 2)
lines(density(extract_theta(ma_cuddy2018$psma, identity, i = index), adjust = 2),
      lwd = 2, 
      lty = 3)
axis(side = 3, 
     at = dat.cuddy2018$yi[index], 
     label = round(dat.cuddy2018$yi[index], 2))
abline(v = dat.cuddy2018$yi[index], col = "grey")
dev.off()  
## Auxilliary values
# publipha::extract_theta(ma_cuddy2018_no$phma)[2]
})
