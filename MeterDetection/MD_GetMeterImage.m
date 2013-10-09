function [subImg] = MD_GetMeterImage (Img,cropRect)

if (cropRect(3) == 0 || cropRect(4) == 0)
fprintf('No Meter Rect found\n');
fprintf('Cropped Rect: %f %f %f %f\n',cropRect(1),cropRect(2),cropRect(3),cropRect(4));
    
    quit cancel;
end

  
fprintf('Cropped Rect: %f %f %f %f\n',cropRect(1),cropRect(2),cropRect(3),cropRect(4));
subImg = imcrop(Img, cropRect);

end