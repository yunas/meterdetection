function [I] = MD_LoadImage 

imageName = 'meter3.JPG';
I       = imread(imageName);
imshow(I);

end