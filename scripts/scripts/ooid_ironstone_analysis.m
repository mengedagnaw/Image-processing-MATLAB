%% ooid_ironstone_analysis.m
% Analysis of Ooid Iron in Ironstone (automated):
% 1) Load image + grayscale
% 2) Contrast enhance (imadjust)
% 3) Binary threshold (imbinarize)
% 4) Noise removal (bwareaopen)
% 5) Separate touching ooids (imerode with disk strel)
% 6) Connected components (bwconncomp) + colored labels (label2rgb)
% 7) Area statistics (regionprops), count objects, total area, % area
% 8) Largest ooid visualization
% 9) Histogram of ooid areas
% 10) Function: total area of ooids larger than the average area
%
% Based directly on the workflow shown in your PDF. :contentReference[oaicite:0]{index=0}

clear; close all; clc;

%% =========================
%  PATH OPTIONS (choose one)
%  =========================
% Option A: absolute path (edit to your file)
imgPath = "/MATLAB Drive/min4.png";

% Option B: GitHub-friendly relative path
% Put the image in: images/min4.png (relative to this .m file location)
% scriptDir = fileparts(mfilename('fullpath'));
% imgPath = fullfile(scriptDir, "..", "images", "min4.png");
% imgPath = string(imgPath);

if ~isfile(imgPath)
    error("Image not found: %s\nCheck the path and filename.", imgPath);
end

%% 1) Load the image + grayscale  (PDF p1) :contentReference[oaicite:1]{index=1}
Irgb = imread(imgPath);
figure('Name','Original'); imshow(Irgb);
title('Original Image');

I = im2gray(Irgb);
figure('Name','Grayscale'); imshow(I);
title('Grayscale Image');

%% 2) Contrast enhancement with imadjust (PDF p2) :contentReference[oaicite:2]{index=2}
I3 = imadjust(I);
figure('Name','Contrast enhanced (imadjust)'); imshow(I3);
title('Contrast Enhanced (imadjust)');

%% 3) Convert to binary with a threshold (PDF p3 uses 0.45) :contentReference[oaicite:3]{index=3}
thresh = 0.45;                 % adjustable
bw0 = imbinarize(I3, thresh);
figure('Name','Binary (raw threshold)'); imshow(bw0);
title(sprintf('Binary Image (threshold = %.2f)', thresh));

%% 4) Remove small white regions (noise reduction) (PDF p4 uses 500) :contentReference[oaicite:4]{index=4}
minAreaPx = 500;               % adjustable
bw1 = bwareaopen(bw0, minAreaPx);
figure('Name','After bwareaopen'); imshow(bw1);
title(sprintf('After bwareaopen (min area = %d px)', minAreaPx));

%% 5) Separate connected ooids using erosion (PDF p5 uses disk radius=3) :contentReference[oaicite:5]{index=5}
seRadius = 3;                  % adjustable
SE = strel('disk', seRadius);
bw = imerode(bw1, SE);
figure('Name','After erosion'); imshow(bw);
title(sprintf('After erosion (disk radius = %d px)', seRadius));

%% 6) Connected components + label visualization (PDF p6–p7) :contentReference[oaicite:6]{index=6}
conn = 4;                      % PDF uses 4-connectivity
cc = bwconncomp(bw, conn);
numberOfObjects = cc.NumObjects;

labeled = labelmatrix(cc);
RGB_label = label2rgb(labeled, 'spring', 'c', 'shuffle');  % PDF example
figure('Name','Labeled objects'); imshow(RGB_label);
title(sprintf('Connected Components (N = %d, %d-connectivity)', numberOfObjects, conn));

%% 7) Area-based statistics (regionprops) (PDF p7–p8) :contentReference[oaicite:7]{index=7}
stats = regionprops(cc, 'Area', 'Centroid', 'BoundingBox');
areas = [stats.Area];                % vector of ooid areas (px^2)

totalOoidArea_px2 = sum(areas);      % sum of component areas (px^2)
avgArea_px2 = mean(areas);
medArea_px2 = median(areas);

% % area occupied by "useful material" (ooids) in the processed binary image
% (This is a pixel fraction; erosion shrinks objects, so it’s a conservative estimate.)
percentUsefulArea = 100 * nnz(bw) / numel(bw);

% Identify largest ooid (PDF p8) :contentReference[oaicite:8]{index=8}
[maxArea_px2, idxMax] = max(areas);

largestOoid = false(size(bw));
largestOoid(cc.PixelIdxList{idxMax}) = true;

figure('Name','Largest ooid'); imshow(largestOoid);
title(sprintf('Largest Ooid (Area = %d px^2, Index = %d)', maxArea_px2, idxMax));

%% 8) Histogram of ooid areas (PDF p9) :contentReference[oaicite:9]{index=9}
figure('Name','Histogram of ooid areas');
histogram(areas);
title('Histogram of Ooid Areas');
xlabel('Area (pixels^2)');
ylabel('Count');

%% 9) Exercise function: total area of ooids larger than the average (PDF p10) :contentReference[oaicite:10]{index=10}
totalAreaAboveAvg_px2 = totalAreaAboveAverage(areas);

%% 10) Print a compact technical summary (report-style)
fprintf("\n============================\n");
fprintf(" OOID IRONSTONE IMAGE REPORT \n");
fprintf("============================\n");
fprintf("Image              : %s\n", imgPath);
fprintf("Threshold (imbinarize)      : %.2f\n", thresh);
fprintf("Min area (bwareaopen)       : %d px\n", minAreaPx);
fprintf("Erosion disk radius         : %d px\n", seRadius);
fprintf("Connectivity (bwconncomp)   : %d\n\n", conn);

fprintf("Number of ooids (objects)   : %d\n", numberOfObjects);
fprintf("Total ooid area (sum areas) : %.0f px^2\n", totalOoidArea_px2);
fprintf("Useful area fraction (bw)   : %.2f %%\n", percentUsefulArea);
fprintf("Average ooid area           : %.2f px^2\n", avgArea_px2);
fprintf("Median ooid area            : %.2f px^2\n", medArea_px2);
fprintf("Largest ooid area           : %.0f px^2 (idx=%d)\n", maxArea_px2, idxMax);
fprintf("Total area > average        : %.0f px^2\n", totalAreaAboveAvg_px2);
fprintf("============================\n\n");

%% =========================
% Helper function (PDF p10)
% =========================
function totalArea = totalAreaAboveAverage(areaVec)
%TOTALAREAABOVEAVERAGE Total area of objects whose area is > average area.
%   totalArea = totalAreaAboveAverage(areaVec)

areaVec = areaVec(:);
areaVec = areaVec(isfinite(areaVec) & areaVec > 0);

if isempty(areaVec)
    totalArea = 0;
    return;
end

avgA = mean(areaVec);
totalArea = sum(areaVec(areaVec > avgA));
end
