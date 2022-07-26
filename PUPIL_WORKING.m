%run('E:\ms1121\Code\makedb_TCB2_MS.m');
makedb_TCB2_EDIT % NEED TO SORT OUT CHANGED VIDEO FILEPATHS FOR MANUAL REMOVAL SCRIP

tcb = [48 51 53 54 57 61];
con = [49 50 52 55 56 60];
all_dlc = sort([tcb con]);

figure
tiledlayout('flow')
axs = [];
for exp = all_dlc

% load spikestruct
%topDir = 'R:\Neuropix\bd126\Analysis\';
%expDir = [topDir 'Exp ' num2str(exp) ' ' db(exp).animal ' ' db(exp).injection{1:end-1}];
%load([expDir '\spikestruct']);
%disp(['Animal: ' db(exp).animal ' Date: ' db(exp).date ' Exp: ' num2str(exp) ' loaded']);

% get frame time stamps
%fTimes_ms = [];
%for c = 1:numel(spikestruct.frameTimes)
%  fTimes_ms = [fTimes_ms;spikestruct.frameTimes{c}];
%end

%fTimes_s = round(fTimes_ms./1000);
%fTimes_ms = round(fTimes_ms);

% calc pupil area from filtered DLC csv output
pup_area = [];
for v = 1:numel(db(exp).pupil)
  [~,area] = calcPupilArea(db(exp).pupil{v});
  pup_area = [pup_area;area];
end

%pup_area(pup_area>10000) = NaN;

ax = nexttile;
plot(pup_area)
ylabel('Pupil Area (mm^2)')
xlabel('Frame')

axs = [axs ax];
end

linkaxes(axs,'xy');