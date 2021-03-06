function [cropRect] = MD_GetMeterRect (edgedImg) 
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
        'Linewidth', 5, 'EdgeColor', 'b', 'LineStyle', '-');
    
        fprintf('%%%%BoundingBox: %f %f %f %f\n',stats(i).BoundingBox(1),stats(i).BoundingBox(2),stats(i).BoundingBox(3),stats(i).BoundingBox(4));
         cropRect =  stats(i).BoundingBox;
        break;
    end
        
end

end
