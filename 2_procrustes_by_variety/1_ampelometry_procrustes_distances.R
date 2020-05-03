# read in the 'shapes' library

library(shapes)

# read in mean shapes for each variety

files <- list.files(path="./output_mean_shapes", pattern="*.txt", full.names=TRUE, recursive=FALSE)

results <- matrix(nrow=60, ncol=60)

for(i in 1:60){
	
	file1 <- files[i]
	variety1 <- read.table(file1, header=FALSE)
	name1 <- substring(file1, 22, (nchar(file1)-9))
	
	for(j in 1:60){
				
		file2 <- files[j]
		variety2 <- read.table(file2, header=FALSE)
		name2 <- substring(file2, 22, (nchar(file2)-9))
		
		print(paste(name1,name2, sep=" by "))

		d <- procdist(as.matrix(variety1), as.matrix(variety2), type="full", reflect=TRUE)
		
		results[i,j] <- d
	
}
}	

write.table(results, "output_procrustes_distance_results.txt")



