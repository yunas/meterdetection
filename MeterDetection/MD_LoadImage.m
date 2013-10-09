function [I] = MD_LoadImage (imageName)

I       = imread(imageName);
imshow(I);

end