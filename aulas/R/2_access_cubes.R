library(sits)

sits_cube(service = "SATVEG",  name = "terra")

cube_terra <- sits_cube(service = "SATVEG",  name = "terra")

sits_get_data(cube_terra, longitude = -55.50563, latitude = -11.71557)

sits_get_data(cube_terra, longitude = -55.50563, latitude = -11.71557) %>% plot()


cube_wtss <- sits_cube(service = "WTSS", name = "MOD13Q1")

system.file("extdata/samples/samples_matogrosso.csv", package = "sits") %>% read.csv()

csv_file <- system.file("extdata/samples/samples_matogrosso.csv", package = "sits")

points.tb <- sits_get_data(cube_wtss, file = csv_file)



# define the timeline
timeline_file <- system.file("extdata/Sinop", "timeline_2014.txt", package = "inSitu")
timeline <- scan(timeline_file, character(), quiet = TRUE)

evi_file <- system.file("extdata/Sinop", "Sinop_evi_2014.tif", package = "inSitu")
ndvi_file <- system.file("extdata/Sinop", "Sinop_ndvi_2014.tif", package = "inSitu")

# create a raster metadata file based on the information about the files
sinop_cube <- sits_cube(service = "BRICK", name = "Sinop",  
                        timeline = timeline,
                        bands = c("ndvi", "evi"), 
                        files = c(ndvi_file, evi_file))

sits_config_show()

sits_get_data(sinop_cube, longitude = -55.50563, latitude = -11.71557) %>% plot()
