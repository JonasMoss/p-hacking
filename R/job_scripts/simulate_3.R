source("R/simulate.R")

results_cl_3 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "cl")
saveRDS(results_cl_3, "data/results_cl_3.Rds")

results_pb_3 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "pb")
saveRDS(results_pb_3, "data/results_pb_3.Rds")

results_ph_3 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "ph")
saveRDS(results_ph_3, "data/results_ph_3.Rds")
