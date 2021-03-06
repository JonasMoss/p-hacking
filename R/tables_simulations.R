## Load data.

results_ph = readRDS(paste0("data/results_", class, "ph.Rds"))
results_pb = readRDS(paste0("data/results_", class, "pb.Rds"))
results_cl = readRDS(paste0("data/results_", class, "cl.Rds"))

#' Make pretty strings.
#' @param x Numeric matrix.
#' @param digits Digits to prettify with.

pretty = function(x, digits = 2, nsmall = 2) {
  y = sapply(x, function(x) format(signif(round(x, digits = digits), digits),
                                   nsmall = nsmall))
  dim(y) = dim(x)
  y
}

#' Make parentheses for means and sds. 
#' 
#' 
#' @param means Vector of means.
#' @param sds Vector of standard deviations.
#' @value A vector of "mean (sd)".
#' @source https://stat.ethz.ch/pipermail/r-help/2011-July/284323.html

msd = function(means, sds) {
  stopifnot(dim(means) == dim(sds))
  y = paste(means, " (", sds, ")", sep = "") 
  dim(y) = dim(means)
  y
} 

## Make table function.
make_table = function(tab, caption, label, file) {
  
  indices = c(1, 6 + 1, 2, 6 + 2, 3, 6 + 3, 4, 6 + 4, 5, 6 + 5, 6, 6 + 6)
  tab = (t(tab))[, indices]
  
  tab = sapply(0:5, function(i) msd(pretty(tab[, 2*i + 1]), 
                                    pretty(tab[, 2*i + 2])))
  
  tab = cbind(c("\\multirow{9}{*}{$0.1$}", "", "", "", "", "", "", "", "", 
                "\\multirow{9}{*}{$0.5$}", "", "", "", "", "", "", "", ""), 
              c("\\multirow{3}{*}{$0$}", "", "", "\\multirow{3}{*}{$0.2$}", "", "", 
                "\\multirow{3}{*}{$0.8$}", "", "", "\\multirow{3}{*}{$0$}", "", "", 
                "\\multirow{3}{*}{$0.2$}", "", "", "\\multirow{3}{*}{$0.8$}", "", ""),
              rep(c("5", "30", "100"), 6),
              tab)
  
  tab = rbind(c("$\\tau$", "$\\theta_0$", "$n$", 
                "\\multicolumn{1}{c}{$\\widehat{\\theta_0}$}",
                "\\multicolumn{1}{c}{$\\widehat{\\tau}$}",
                "\\multicolumn{1}{c}{$\\widehat{\\theta_0}$}",
                "\\multicolumn{1}{c}{$\\widehat{\\tau}$}",
                "\\multicolumn{1}{c}{$\\widehat{\\theta_0}$}", 
                "\\multicolumn{1}{c}{$\\widehat{\\tau}$}"), tab)
  
  
  addtorow = list()
  addtorow$pos = list(0, 10, 7, 4, 13, 16)
  addtorow$command = c("\\multicolumn{3}{r}{\\textbf{True values}} & 
       \\multicolumn{2}{c}{\\textbf{\\textit{p}-hacking model}} &
       \\multicolumn{2}{c}{\\textbf{Publication bias model}} &
       \\multicolumn{2}{c}{\\textbf{Classical model}}\\\\",
                       "\\cline{2-9}\n",
                       "\\cdashline{3-9}\n",
                       "\\cdashline{3-9}\n",
                       "\\cdashline{3-9}\n",
                       "\\cdashline{3-9}\n")
  
  tab = xtable::xtable(tab, label = label, 
                       caption = caption,
                       align = c("l","l", "l", "l", rep("r", 6)))
  
  tab = print(tab, sanitize.rownames.function = identity,
        sanitize.colnames.function = identity, 
        sanitize.text.function = identity,
        add.to.row = addtorow,
        include.rownames = FALSE, 
        include.colnames = FALSE,
        hline.after = c(1, nrow(tab)),
        caption.placement = "top",
        print.results = FALSE)
  
  writeLines(tab, file)
}

## Generate the tables.

tab_ph = make_table(tab = results_ph,
                    caption = "{\\bf \\textit{p}-hacking.} Posterior means and 
                    standard deviations from the \\textit{p}-hacking and 
                    publication bias models when the data are simulated 
                    from the \\textit{p}-hacking model with cut-offs at
                    $0.025$ and $0.05$, with \\textit{p}-hacking probabilities
                    equal to $0.6$, $0.3$, and $0.1$ in the intervals
                    $[0, 0.025)$, $[0.025, 0.05)$, and $[0.5, 1]$",
                    label = "tab:Simulation_ph",
                    file = paste0("tables/simulations_", class, "ph.tex"))

tab_pb = make_table(tab = results_pb, 
                    caption = "{\\bf Publication bias.} 
                    Posterior means and standard deviations from the 
                    \\textit{p}-hacking and publication bias models 
                    when the data are simulated from the publication 
                    bias model with cut-offs at $0.025$ and $0.05$, 
                    with selection probabilities equal to $1$, $0.7$, 
                    and $0.1$ in the intervals $[0, 0.025)$, $[0.025, 0.05)$, 
                    and $[0.5, 1]$.",
                    label = "tab:Simulation_pb",
                    file = paste0("tables/simulations_", class, "pb.tex"))

tab_cl = make_table(tab = results_cl,
                    caption = "{\\bf No publication bias, no 
                    \\textit{p}-hacking.} Posterior means 
                    and standard deviations from the \\textit{p}-hacking 
                    and publication bias models when the data are simulated 
                    from the normal random effects meta-analysis model.",
                    label = "tab:Simulation_classical",
                    file = paste0("tables/simulations_", class, "cl.tex"))

