function [bw] = MD_ImgByApplyingEdgeDetection (I) 

    imshow (I);
    I = imsharpen(I);
    
    imshow (I);
    
    gmap    = rgb2gray(I);
    bw      = edge(gmap,'sobel',0.05);
    
    imshow (bw);
    
end
