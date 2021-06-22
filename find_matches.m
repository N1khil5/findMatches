function [pos2]=find_matches(I1,pos1,I2)
% This function implements a computer vision system to solve the
% correspondence problem. This video uses part of the Youtube tutorial from
% matlab on matching image features. A link for the video is referenced
% below. The function reads the two images, uses HarrisRegions to detect
% the corners for the two images. The next part of the function extracts
% useful features from the images which gets the interest point descriptors.
% Then the features are matched together and we estimate the geometric
% transformation for the matching point pairs and we get the output pos2.
%
%References: Matlab Youtube Video: https://www.youtube.com/watch?v=E0ZmFhFMoks&t=1s&ab_channel=MATLAB
% Commenting out images used for testing.
% I1=im2double(imread('leuven/img1.png'));
% I2=im2double(imread('leuven/img2.png'));
%Converts the two images to grayscale.
I1gray=rgb2gray(I1);
I2gray=rgb2gray(I2);

%detect corners of both grayscale images using the Harris-Stephens
%algorithm
HarrisRegions1 = detectHarrisFeatures(I1gray);
HarrisRegions2 = detectHarrisFeatures(I2gray);
%pos1 has been commented out below since it will be an input. The code
%below is what was used when testing the program.

% pos1=HarrisRegions1.Location;

%Extract features of the two images. This gets interest point descriptors
%of the features and their valid positions
[features1,x] = extractFeatures(I1gray,HarrisRegions1);
[features2,y] = extractFeatures(I2gray,HarrisRegions2);

%Matching features of the two images from their interest point descriptors
%and their valid positions
indexPairs = matchFeatures(features1,features2);

%Get points that 'match'
matchedPoints1 = x(indexPairs(:,1));
matchedPoints2 = y(indexPairs(:,2));

%Estimate 2D geometric transformation from the matching point pairs 
tform = estimateGeometricTransform2D(matchedPoints1,matchedPoints2,'similarity');
%Applies forward geometric transformation to find the matrix values of pos2
pos2 = transformPointsForward(tform,pos1);

%Code to output the size of the matrix to confirm that pos1 and pos2 are of
%the same size. 
% size(pos1)
% size(pos2)

%Show matched features
figure
showMatchedFeatures(I1,I2, matchedPoints1, matchedPoints2,'montage');