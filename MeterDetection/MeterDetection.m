function MeterDetection

% imageName = 'meter2.JPG';
% I       = imread(imageName);
% imageName = 'sampleImage.JPG';
% imageName = 'sampleImage1.jpg';
 
%   bw= edge(gmap,'prewitt',0.05);  
%   bw = edge(gmap,'canny',0.1);
imageName = 'meter1.JPG';

I = MD_LoadImage(imageName);    
bw = MD_ImgByApplyingEdgeDetection(I);
cropRect = MD_GetMeterRect(bw);
meterImg = MD_GetMeterImage (I,cropRect);
imshow(meterImg);

 
end












