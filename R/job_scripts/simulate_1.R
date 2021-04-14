source("R/simulate.R")

results_cl_1 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "cl")
saveRDS(results_cl_1, "data/results_cl_1.Rds")

results_pb_1 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "pb")
saveRDS(results_pb_1, "data/results_pb_1.Rds")

results_ph_1 = apply(X = parameters, MARGIN = 1, FUN = FUN, type = "ph")
saveRDS(results_ph_1, "data/results_ph_1.Rds")
