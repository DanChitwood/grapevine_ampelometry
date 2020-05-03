# read in the 'shapes' library

library(shapes)

# read in interpolated points for all leaves

interpolated_points <- read.table("../1_interpolation/output_interpolated_points.txt", header=TRUE)

# get names of varieties

varieties <- unique(interpolated_points[11999])

# for each variety, perform a separate Procrustes analysis and save results
# for all pairwise distances, about a 7 hour run time on 2018 MacBook Pro 2.6 GHz 6-Core Intel Core i7 16GB 2400 MHz DDR4

for(i in 1:60){
	
	print(i)
	
	variety <- as.character(varieties[i,])
	variety_pts <- subset(interpolated_points, Variety==variety)
	coordinates <- as.matrix(variety_pts[1:4, 1:11998])
	write.table(coordinates, "./coordinates.txt", row.names=F, col.names=F)
	k <- 5999
	m <- 2
	n <- 4
	data <- read.in("./coordinates.txt",k,m)
	GPA <- procGPA(data, reflect=TRUE, distances=FALSE, pcaoutput=FALSE)   
	
	
	pa <- as.matrix(GPA$rotated)
	write.table(pa, file=paste("./output_procrustes_coordinates/",variety,"_adjusted.txt", sep=""), row.names=F, col.names=F)
	
	mean_shape <- as.matrix(GPA$mshape)
	write.table(mean_shape, file=paste("./output_mean_shapes/",variety,"_mean.txt", sep=""), row.names=F, col.names=F)
	
}
