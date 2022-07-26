function [pupilAreaPix, pupilAreaMM] = calcPupilArea(csvfile, mirror, convFactor)
% [pupilAreaPix, pupilAreaMM] = calcPupilArea(csvfile, convFactor)
%
% Function extracts pupil area info from the deeplabcut csv file after
% labeling an eye-tracking video.
% Input: csvFile - a full path to the csv file of interest.
%        convFactor - pixel to mm conversion factor (optional). Default is
%                     to assume the average pupil diameter to be 1 mm.
% Output: pupilAreaPix - pupil area in arbitrary units (most likely in
%                        pixels^2; not converted to SI units).
%         pupilAreaMM - pupil area in mm^2.


%% Pupil area in pixels 
dlcData = readtable(csvfile);
coordColumns = 1 + [1 2 4 5 7 8 10 11];
if verLessThan('matlab', '9.8')
   dlcCoordData = str2double(table2array(dlcData(3:end,coordColumns)));
else
   dlcCoordData = str2double(table2array(dlcData(:,coordColumns))); % later version autocorrects headers
end
if mirror == 1
  dlcCoordData = dlcCoordData(1:end-1,:); % remove duplicated last frame
end

distVec1 = distCalc(dlcCoordData(:,1:2), dlcCoordData(:,3:4));
distVec2 = distCalc(dlcCoordData(:,5:6), dlcCoordData(:,7:8));
pupilAreaPix = (0.25*pi).*distVec1.*distVec2; % area of ellipse
%pupilAreaPix = pi.*((0.5.*distVec2).^2); % area of circle - using only horizontal coordinates

%% Exclude low likelihood values
likelihoodColumns = 1 + [3 6 9 12];
if verLessThan('matlab', '9.8') 
  likelihood = str2double(table2array(dlcData(3:end,likelihoodColumns)));
else
  likelihood = str2double(table2array(dlcData(:,likelihoodColumns))); % later version autocorrects headers
end
if mirror == 1
  likelihood = likelihood(1:end-1,:); % remove duplicated last frame
end

M_likelihood = mean(likelihood,2);

pupilAreaPix(M_likelihood<0.2) = NaN; % exclude values with weak DLC tracking

%% Pupil area in milimeters
if nargin < 3
  convFactor = 1/mean([mean(distVec1) mean(distVec1)]);
end
pupilAreaMM = pupilAreaPix.*(convFactor^2);

pupilAreaMM(pupilAreaMM > 4 | pupilAreaMM < 0.2) = NaN; % threshold for exclusion of extreme values

%% Local functions
function distVec = distCalc(coordVec1, coordVec2)
% Distance between two (x,y) coordinate vectors

distVec = sqrt(sum((coordVec1-coordVec2).^2,2));