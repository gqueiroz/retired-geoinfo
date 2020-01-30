
library(sits)

samples_mt_4bands %>% sits_labels()


patterns <- sits_patterns(samples_mt_4bands)

plot(patterns)

point_mt_4bands <- sits_select_bands(point_mt_6bands, "ndvi", "evi", "nir", "mir")

matches <- sits_twdtw_classify(point_mt_4bands, patterns, 
                               bands = c("ndvi", "evi", "nir", "mir"),
                               alpha = -0.1, beta = 100, theta = 0.5, keep = TRUE)




svm_model <- sits_train(samples_mt_4bands, ml_method = sits_svm())

matches <- sits_classify(point_mt_4bands, ml_model = svm_model)

plot(matches)


rfor_model <- sits_train(samples_mt_4bands, ml_method = sits_rfor(num_trees = 500))

matches <- sits_classify(point_mt_4bands, ml_model = rfor_model)

plot(matches)


dl_model <-  sits_train(samples_mt_4bands,
                        ml_method = sits_deeplearning(
                          layers           = c(512, 512, 512, 512),
                          activation       = 'relu',
                          dropout_rates    = c(0.50, 0.40, 0.35, 0.25),
                          epochs           = 50,
                          batch_size       = 128,
                          validation_split = 0.2))

matches <- sits_classify(point_mt_4bands, ml_model = dl_model)

plot(matches)

