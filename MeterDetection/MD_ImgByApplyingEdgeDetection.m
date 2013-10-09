function [bw] = MD_ImgByApplyingEdgeDetection (I) 

%     imshow (I);
%     
%     GRAY = rgb2gray(I);
%     threshold = graythresh(GRAY);
%     BW1 = im2bw(GRAY, threshold);
%     BW1 = ~ BW1;
%     bw      = edge(BW1,'sobel',0.05);
    I = imsharpen(I);
    
    imshow (I);
    
    gmap    = rgb2gray(I);
    bw      = edge(gmap,'sobel',0.05);
    
    imshow (bw);
    
end
