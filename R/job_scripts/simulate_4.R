source("R/simulate.R")

results_cl_4 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "cl")
saveRDS(results_cl_4, "data/results_cl_4.Rds")

results_pb_4 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "pb")
saveRDS(results_pb_4, "data/results_pb_4.Rds")

results_ph_4 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "ph")
saveRDS(results_ph_4, "data/results_ph_4.Rds")
