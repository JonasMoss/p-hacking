source("R/simulate.R")

results_cl_2 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "cl")
saveRDS(results_cl_2, "data/results_cl_2.Rds")

results_pb_2 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "pb")
saveRDS(results_pb_2, "data/results_pb_2.Rds")

results_ph_2 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "ph")
saveRDS(results_ph_2, "data/results_ph_2.Rds")

