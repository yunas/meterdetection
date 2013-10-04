function MeterDetection

imageName = 'meter1.JPG';
I       = imread(imageName);
% imageName = 'sampleImage.JPG';
% imageName = 'sampleImage1.jpg';
 
%   bw= edge(gmap,'prewitt',0.05);  
%   bw = edge(gmap,'canny',0.1);
    
bw = imgByApplyingEdgeDetection(I);
cropRect = getMeterRect(bw);
meterImg = getMeterImage (I,cropRect);
imshow(meterImg);

 
end


function [bw] = imgByApplyingEdgeDetection (I) 

    imshow (I);
    I = imsharpen(I);
    
    imshow (I);
    
    gmap    = rgb2gray(I);
    bw      = edge(gmap,'sobel',0.05);
    
    imshow (bw);
    
end


function [cropRect] = getMeterRect (edgedImg) 
%     imshow(bw);
 
     bw = im2bw(edgedImg);

% find both black and white regions
    stats = [regionprops(bw); regionprops(not(bw))]
    
% show the image and draw the detected rectangles on it
    imshow(bw); 
    
    hold on;

    cropRect = zeros(4,1);
    innerCount = 0;
    
for i = 1:numel(stats)
    x = stats(i).BoundingBox(1);
    y = stats(i).BoundingBox(2);
    width = stats(i).BoundingBox(3);
    height = stats(i).BoundingBox(4);
    
    if (width > 300 && height > 300 && x > 20 && y > 20)
     rectangle('Position', stats(i).BoundingBox, ...
        'Linewidth', 13, 'EdgeColor', 'b', 'LineStyle', '-');
    
        fprintf('%%%%BoundingBox: %f %f %f %f\n',stats(i).BoundingBox(1),stats(i).BoundingBox(2),stats(i).BoundingBox(3),stats(i).BoundingBox(4));
         cropRect =  stats(i).BoundingBox;
        break;
    end
        
end

end


function [subImg] = getMeterImage (Img,cropRect)

if (cropRect(3) == 0 || cropRect(4) == 0)
fprintf('No Meter Rect found\n');
fprintf('Cropped Rect: %f %f %f %f\n',cropRect(1),cropRect(2),cropRect(3),cropRect(4));
    
    quit cancel;
end

  
fprintf('Cropped Rect: %f %f %f %f\n',cropRect(1),cropRect(2),cropRect(3),cropRect(4));
subImg = imcrop(Img, cropRect);

end

