
library(sits)

timeline_file <- system.file("extdata/Sinop", "timeline_2014.txt", package = "inSitu")
timeline <- scan(timeline_file, character(), quiet = TRUE)

evi_file <- system.file("extdata/Sinop", "Sinop_evi_2014.tif", package = "inSitu")
ndvi_file <- system.file("extdata/Sinop", "Sinop_ndvi_2014.tif", package = "inSitu")

sinop_cube <- sits_cube(service = "BRICK", name = "Sinop",  
                        timeline = timeline,
                        bands = c("ndvi", "evi"), 
                        files = c(ndvi_file, evi_file))



samples_mt_4bands %>% sits_labels()

samples_ndvi_evi <- sits_select_bands(samples_mt_4bands, "ndvi", "evi")

rfor_model <- sits_train(samples_ndvi_evi, ml_method = sits_rfor(num_trees = 500))

sinop_probs <- sits_classify(sinop_cube, ml_model = rfor_model, memsize = 2, multicores = 1)

sinop_probs$files

sinop_map3 <- sits_label_classification(sinop_probs)

plot(sinop_map3, title = "Sinop")

sinop_map4 <- sits_label_classification(sinop_probs, smoothing = "bayesian")

plot(sinop_map4, title = "Sinop-smooth")

