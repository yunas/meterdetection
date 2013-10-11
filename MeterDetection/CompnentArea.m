I = imread('rice.png');
imshow(I)

%Use Morphological Opening to Estimate the Background
background = imopen(I,strel('disk',15));

% Display the Background Approximation as a Surface
figure, surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
set(gca,'ydir','reverse');

%Subtract the Background Image from the Original Image
I2 = I - background;
imshow(I2)

%Increase the Image Contrast
I3 = imadjust(I2);
imshow(I3);

%Threshold the Image
level = graythresh(I3);
bw = im2bw(I3,level);
bw = bwareaopen(bw, 50);
imshow(bw)

%Identify Objects in the Image
cc = bwconncomp(bw, 4);

%Examine One Object
grain = false(size(bw));
grain(cc.PixelIdxList{50}) = true;
imshow(grain);

%View All Objects
%labeled = labelmatrix(cc);

%Compute Area of Each Object
graindata = regionprops(cc,'basic')
graindata(50).Area

%Compute Area-based Statistics
grain_areas = [graindata.Area];

%Find the grain with the smallest area.
[min_area, idx] = min(grain_areas)
grain = false(size(bw));
grain(cc.PixelIdxList{idx}) = true;
imshow(grain);

% Create Histogram of the Area
%nbins = 20;
%figure, hist(grain_areas,nbins)
%title('Histogram of Rice Grain Area');













