
function [PA] = create_PA(db,exp)

% load spikestruct
file_path = ['E:\ms1121\Analysis Testing\Exp_' num2str(exp) '_' db(exp).animal '_' db(exp).date '\spikestruct'];
load(file_path);    
%[spikestruct] = load_spikestruct(db,exp);

% extract key info
PA.exp = exp;
if isfield(spikestruct,'animal')
  PA.animal = spikestruct.animal;
  PA.date = spikestruct.date;
elseif isfield(spikestruct,'meta')
  PA.animal = spikestruct.meta.animal;
  PA.date = spikestruct.meta.date;
end
PA.dose = db(exp).dose;
PA.cond_timepoints = round(spikestruct.timepoints);
if PA.cond_timepoints(1) < 1 % correct for rounding error
  PA.cond_timepoints(1) = 1;
end
PA.pup_area = spikestruct.pup_area';

% get frame time stamps
fTimes_ms = [];
fTime_marker = [];
for c = 1:numel(spikestruct.frameTimes)
  fTimes_ms = [fTimes_ms;spikestruct.frameTimes{c}];
  fTime_marker = [fTime_marker numel(spikestruct.frameTimes{c})];
end
PA.fTimes_ms = round(fTimes_ms);
PA.fTime_marker = fTime_marker;
PA.aligned_fTime_marker = []; % empty array for later alignment

% get frame idx of start_drinking
if numel(spikestruct.frameTimes)==3
  PA.start_drink_fr = numel(spikestruct.frameTimes{1})+1;
elseif numel(spikestruct.frameTimes)==5
  PA.start_drink_fr = numel(spikestruct.frameTimes{1})+numel(spikestruct.frameTimes{2})+1;
else
  disp(['Exp: ' num2str(exp) ' Different number of frameTimes.'])
end

% get population rate
PA.populationrate = spikestruct.populationrate;

end