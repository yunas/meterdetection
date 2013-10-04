function [theta] = Canny_18_OrientationDetection(sig, imageName, Th, Tl)
% Canny Edge Detection implementation
% by Muhammad Shahid Farid

% Check for correct number of arguments
if (nargin ~= 4)
  error('ERROR: Invalid number of parameters');
end

% Validate the value of sigma and thresold bounds
if (sig <= 0 || sig > 4)
  error('ERROR: Invalid value of sigma. Sigma should be between 0 and 4 ');
end
if (Th < Tl)
  error('ERROR: Th < Tl');
end

fx = GenerateMask(sig);
s = size(fx);
hs = ceil(s/2);
im = imread(imageName);

if ndims(im) == 3
    gim = double(rgb2gray(im));
else
    gim = double(im);
end

% Convolve the image with Horizontal and Vertical Masks
fy = fx';
im2 = conv2(gim, fx, 'same');
im3 = conv2(gim, fy, 'same');


% Display the convolved images and save them
% set(0,'DefaultFigurePaperPositionMode','auto');
% str = strcat('This call is: canny(',int2str(sig),',   ',imageName,',   ', int2str(Th),',   ', int2str(Tl),')');
% figure, imagesc(im);
% title(str);
% colormap gray;
% truesize;

% Make a file name to save this image
% position = findstr('.', imageName);
% name = imageName(1:position-1);
% time  = datestr(now, 'HHMMSS');
% fn = strcat(name,time,'.pdf');
% print('-f1', '-dpdf', fn);
% 
% figure, imagesc(im2);
% title('Convolved Image with fx mask');
% colormap gray;
% truesize;
% print('-f2', '-dpdf', '-append', fn);
% 
% figure, imagesc(im3);
% title('Convolved Image with fy mask');
% colormap gray;
% truesize;
% 
% % Make a file name to save this image
% % time  = datestr(now, 'HHMMSS');
% % imwrite(im3,strcat(name,'-fy-',time,'.jpg'));
% 
% print('-f3', '-dpdf', '-append', fn);
% 


% Find the Gradient Magnitude and direction, save them in a matrices
% gradient and direction
[m, n] = size(im2);
for i=1:m
    for j=1:n
%         gradient(i, j) = sqrt(im2(i, j)^2 + im3(i, j)^2);
        angle = atan2(im3(i, j), im2(i, j));
        angle = rad2deg(angle);
        angle = angle + 180;
        theta(i, j) = mod(angle,180);
    end
end



end

