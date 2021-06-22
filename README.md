# findMatches
Computer Vision program to solve the correspondence problem.The function reads the two images, uses HarrisRegions to detect
the corners for the two images. The next part of the function extracts useful features from the images which gets the interest point descriptors. Then the features are matched together and we estimate the geometric transformation for the matching point pairs and we get the output pos2.
