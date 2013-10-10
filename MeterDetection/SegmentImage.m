function SegmentImage (I)


% I = imread('meter1.jpg');
IGray = rgb2gray(I);
% I = imread('cell.tif');
figure, imshow(I), title('original image');
text(size(I,2),size(I,1)+15, ...
    'Image courtesy of Alan Partin', ...
    'FontSize',7,'HorizontalAlignment','right');
text(size(I,2),size(I,1)+25, ....
    'Johns Hopkins University', ...
    'FontSize',7,'HorizontalAlignment','right');


% Step 2

[~, threshold] = edge(IGray, 'sobel');
fudgeFactor = .5;
BWs = edge(IGray,'sobel', threshold * fudgeFactor);
figure, imshow(BWs), title('binary gradient mask');

% Step 3 a

se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);

% Step 3 b

BWsdil = imdilate(BWs, [se90 se0]);
figure, imshow(BWsdil), title('dilated gradient mask');

% MD_GetMeterRect(BWsdil);

% Step 4: Fill Interior Gaps

BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('binary image with filled holes');

% Step 5: Remove Connected Objects on Border
BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('cleared border image');

% Step 6: Smoothen the Object

seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal), title('segmented image');


BWoutline = bwperim(BWfinal);
% figure, imshow(BWoutline), title('outlined image');


Segout = I;
Segout(BWoutline) = 255;
figure, imshow(Segout), title('outlined original image');


end