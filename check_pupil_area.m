                  %'R:\Neuropix\Shared\Data\M191023_A_BD\131119\video_48653_processed.mat',...
                  %'R:\Neuropix\Shared\Data\M191023_A_BD\131119\video_50880_processed.mat',...
                  %'R:\Neuropix\Shared\Data\M191023_A_BD\191119\video_51156_processed.mat',...
                  %'R:\Neuropix\Shared\Data\M191023_A_BD\191119\video_53499_processed.mat',...
                  %'R:\Neuropix\Shared\Data\M191023_A_BD\191119\video_56100_processed.mat',...

% compare dlc pupil area with matlab processed area

makedb_TCB2_MS

tcb = [48 51 54 57 61]; % 53
con = [49 50 55 56 60]; % 52
all_dlc = sort([tcb con]);
all_dlc = Batch2PFC(5:16);

processed_files = {'E:\Data\M190930_B_BD\011119\video_64023_processed.mat',...
                  'E:\Data\M190930_B_BD\011119\video_66192_processed.mat',...
                  'E:\Data\M190930_B_BD\051119\video_51045_processed.mat',...
                  'E:\Data\M190930_B_BD\051119\video_53199_processed.mat',...
                  'E:\Data\M190930_A_BD\071119\video_49065_processed.mat',...
                  'E:\Data\M190930_A_BD\071119\video_50922_processed.mat',...
                  'E:\Data\M190930_A_BD\081119\video_54234_processed.mat',...
                  'E:\Data\M190930_A_BD\081119\video_56438_processed.mat',...
                  'E:\Data\M191023_B_BD\191119\video_69584_processed.mat',...
                  'E:\Data\M191023_B_BD\191119\video_71796_processed.mat',...
                  'E:\Data\M191023_B_BD\201119\video_59071_processed.mat',...
                  'E:\Data\M191023_B_BD\201119\video_61265_processed.mat',...
                  'E:\Data\M191114_B_BD\261119\video_71257_processed.mat',...
                  'E:\Data\M191114_B_BD\261119\video_73494_processed.mat',...
                  'E:\Data\M191114_B_BD\271119\video_66679_processed.mat',...
                  'E:\Data\M191114_B_BD\271119\video_68877_processed.mat',...
                  'E:\Data\M191129_A_BD\111219\video_58774_processed.mat',...
                  'E:\Data\M191129_A_BD\111219\video_60980_processed.mat',...
                  'E:\Data\M191129_A_BD\121219\video_65307_processed.mat',...
                  'E:\Data\M191129_A_BD\121219\video_67471_processed.mat'};
check_old = false;

figure
tiledlayout('flow')
axs = [];
i = 1;
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

%pup_area(pup_area>4 | pup_area<0.2) = NaN;

%pup_area(pup_area>10000) = NaN;

ax = nexttile;
%plot(pup_area)
%ylabel('Pupil Area (mm^2)')
%xlabel('Frame')
%title([db(exp).animal ' ' db(exp).date])

if check_old == true
  load(processed_files{i},'results');
  area1 = results.area;
  load(processed_files{i+1},'results');
  area2 = results.area;
  old_area = [area1;area2];
  %hold on
  plot(old_area/nanmean(old_area))
  %hold off
end

hold on
plot(pup_area)
ylabel('Pupil Area (mm^2)')
xlabel('Frame')
title([db(exp).animal ' ' db(exp).date])
hold off

i = i+2;
axs = [axs ax];
end

linkaxes(axs,'xy');
ylim([0 5])



 