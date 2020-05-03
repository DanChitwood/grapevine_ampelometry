#Read in the 'shapes' library
library(shapes)

#SPECIFY LANDMARK NUMBER (K), LANDMARK DIMENSIONS (M), and NUMBER OF SAMPLES (N)
#########

k <- 5999
m <- 2
n <- 240

#READ IN DATA WITH ASSOCIATED PARAMETERS
#########

# coordinates is the "../1_interpolation/output_number_of_points.txt" file stripped of colnames and rownames

data <- read.in("./ampelometry_coordinates.txt",k,m)

#PERFORM PROCRUSTES ANALYSIS, ALLOW REFLECTION (distances = FALSE to speed things up)
########

# for all 240 leaves, about a 45 minute run time on 2018 MacBook Pro 2.6 GHz 6-Core Intel Core i7 16GB 2400 MHz DDR4

GPA <- procGPA(data, reflect=TRUE, distances=FALSE)   

#LOOK AT THE PROCRUSTES PCS AND THE EIGENLEAVES
##########

#How much variance does each PC represent?

percents <- GPA$percent

write.table(percents, file="output_procrustes_percents.txt")

#We can use the default function shapcepca() to "look" at the PCs
#Eigenleaves saves in the folder "output_eigenleaves"

shapepca(GPA, pcno=1)

#Write out the Procrustes-adjusted coordinates
###########

pa <- as.matrix(GPA$rotated)

write.table(pa, file="output_procrustes_adjusted.txt")

#Write out the mean shape
###########

mean_shape <- as.matrix(GPA$mshape)

write.table(mean_shape, file="output_procrustes_mean_shape.txt")

#Write out PC scores
###########

pca_scores <- GPA$stdscores

write.table(pca_scores, file="output_procrustes_pca_scores.txt")
