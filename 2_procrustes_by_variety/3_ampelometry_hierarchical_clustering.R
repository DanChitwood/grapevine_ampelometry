# read in the 'shapes' library

library(shapes)

# read in interpolated points for all leaves

data <- read.table("./output_procrustes_distance_results.txt", header=TRUE)

dis <- dist(data)

hc <- hclust(dis, method="mcquitty")

plot(hc)
