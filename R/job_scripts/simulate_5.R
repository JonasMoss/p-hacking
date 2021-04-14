source("R/simulate.R")

results_cl_5 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "cl")
saveRDS(results_cl_5, "data/results_cl_5.Rds")

results_pb_5 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "pb")
saveRDS(results_pb_5, "data/results_pb_5.Rds")

results_ph_5 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "ph")
saveRDS(results_ph_5, "data/results_ph_5.Rds")
