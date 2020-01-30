library(sits)
library(tibble)

samples_mt_6bands

sits_labels(samples_mt_6bands)

sits_bands(samples_mt_6bands)

sits_select_bands(samples_mt_6bands, "ndvi")

sits_select_bands(samples_mt_6bands, "ndvi") %>% sits_bands()



point_ndvi

sits_labels(point_ndvi)

sits_bands(point_ndvi)

plot(point_ndvi)

sits_whittaker(point_ndvi) %>% plot()

sits_whittaker(point_ndvi, lambda = 10) %>% 
  sits_merge(point_ndvi) %>% 
  plot()


devtools::install_github("e-sensing/inSitu")

library(inSitu)

inSitu::list_datasets()
