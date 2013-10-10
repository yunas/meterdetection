function watershedSegmentation

rgb = imread('pears.png');
I = imgInGrayScale (rgb);
gradmag = getGradientMagnitude(I); 
Iobrcbr = markForgroundObjects(I);
[bw,bgm] = markBackgroundMarkers (Iobrcbr);
computeWatershedTranform(gradmag,bgm,fgm4);
visualizeResult (I, bgm, fgm4, L);

end

% Step 1: Read in the Color Image and Convert it to Grayscale
function [grayScaleImage] = imgInGrayScale (rgb)



grayScaleImage = rgb2gray(rgb);
imshow(grayScaleImage)

text(732,501,'Image courtesy of Corel(R)',...
     'FontSize',7,'HorizontalAlignment','right')
 


end

% Step 2: Use the Gradient Magnitude as the Segmentation Function
function [gradmag] = getGradientMagnitude (I) 

    hy = fspecial('sobel');
    hx = hy';
    Iy = imfilter(double(I), hy, 'replicate');
    Ix = imfilter(double(I), hx, 'replicate');
    gradmag = sqrt(Ix.^2 + Iy.^2);
    figure, imshow(gradmag,[]), title('Gradient magnitude (gradmag)')
    

end

% Step 3: Mark the Foreground Objects
function [Iobrcbr,fgm4] = markForgroundObjects (I)

se = strel('disk', 20);
Io = imopen(I, se);
figure, imshow(Io), title('Opening (Io)')

Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
figure, imshow(Iobr), title('Opening-by-reconstruction (Iobr)')

Ioc = imclose(Io, se);
figure, imshow(Ioc), title('Opening-closing (Ioc)')

Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
figure, imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')

fgm = imregionalmax(Iobrcbr);
figure, imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')

I2 = I;
I2(fgm) = 255;
figure, imshow(I2), title('Regional maxima superimposed on original image (I2)')

se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);

fgm4 = bwareaopen(fgm3, 20);
I3 = I;
I3(fgm4) = 255;
figure, imshow(I3)
title('Modified regional maxima superimposed on original image (fgm4)')



end

% Step 4: Compute Background Markers
function [bw,bgm] = markBackgroundMarkers (Iobrcbr)

bw = im2bw(Iobrcbr, graythresh(Iobrcbr));
figure, imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')

D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
figure, imshow(bgm), title('Watershed ridge lines (bgm)')

end

% Step 5: Compute the Watershed Transform of the Segmentation Function.
function [L] = computeWatershedTranform (gradmag, bgm, fgm4)

gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(gradmag2);

end

% Step 6: Visualize the Result
function  visualizeResult (I, bgm, fgm4, L)

I4 = I;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
figure, imshow(I4)
title('Markers and object boundaries superimposed on original image (I4)')

Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
figure, imshow(Lrgb)
title('Colored watershed label matrix (Lrgb)')

figure, imshow(I), hold on
himage = imshow(Lrgb);
set(himage, 'AlphaData', 0.3);
title('Lrgb superimposed transparently on original image')


end
