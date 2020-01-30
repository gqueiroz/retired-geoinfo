
library(sits)


results <- list()

conf_svm.tb <- sits_kfold_validate(samples_mt_4bands,
                                   folds = 5,
                                   multicores = 1,
                                   ml_method = sits_svm(kernel = "radial", cost = 10))

conf_svm.mx <- sits_conf_matrix(conf_svm.tb)

conf_svm.mx$name <- "svm_10"

results[[length(results) + 1]] <- conf_svm.mx




conf_rfor.tb <- sits_kfold_validate(samples_mt_4bands,
                                    folds = 5,
                                    multicores = 1,
                                    ml_method = sits_rfor(num.trees = 500))

conf_rfor.mx <- sits_conf_matrix(conf_rfor.tb)

conf_rfor.mx$name <- "rfor"

results[[length(results) + 1]] <- conf_rfor.mx




conf_lda.tb <- sits_kfold_validate(samples_mt_4bands,
                                   folds = 5,
                                   multicores = 1,
                                   ml_method = sits_lda())

conf_lda.mx <- sits_conf_matrix(conf_lda.tb)

conf_lda.mx$name <- "lda"

results[[length(results) + 1]] <- conf_lda.mx




conf_mlr.tb <- sits_kfold_validate(samples_mt_4bands,
                                   folds = 5,
                                   multicores = 2,
                                   ml_method = sits_mlr())

conf_mlr.mx <- sits_conf_matrix(conf_mlr.tb)

conf_mlr.mx$name <- "mlr"

results[[length(results) + 1]] <- conf_mlr.mx



WD = getwd()

sits_to_xlsx(results, file = paste0(WD, "/accuracy_mt_ml.xlsx"))
