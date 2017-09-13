library('datasets')

# Data sets to use
data_sets <- c("trees", "warpbreaks", "swiss", "quakes", "iris",
               "airquality", "birthwt", "kidney")

# Names of all data sets
all_names <- data()$results[,"Item"]

# Get the indices for the data sets I want
dat_index <- sapply(1:length(data_sets),
                    function(i) grep(paste0('\\b', data_sets[i], '\\b'), all_names))
dat_index <- unlist(dat_index)

# Names and titles of the data sets I want
dat_names <- all_names[dat_index]
dat_titles <- data()$results[,"Title"][dat_index]

