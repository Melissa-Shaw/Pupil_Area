%run('E:\ms1121\Code\makedb_TCB2_MS.m');
makedb_TCB2_EDIT % NEED TO SORT OUT CHANGED VIDEO FILEPATHS FOR MANUAL REMOVAL SCRIP

tcb = [48 51 53 54 57 61 66];
con = [49 50 52 55 56 60 68];

exp = 48;

% load spikestruct
%[spikestruct] = load_spikestruct(db,exp);
file_path = ['E:\ms1121\Analysis Testing\Exp_' num2str(exp) '_' db(exp).animal '_' db(exp).date '\spikestruct'];
load(file_path);

% get frame time stamps
fTimes_ms = [];
for c = 1:numel(spikestruct.frameTimes)
  fTimes_ms = [fTimes_ms;spikestruct.frameTimes{c}];
end
fTimes_s = round(fTimes_ms./1000);
fTimes_ms = round(fTimes_ms);

% get pupil area
pup_area = spikestruct.pup_area;
pop_rate = spikestruct.pop_rate;

% plot
plot_single_recording(pup_area,pop_rate,fTimes_ms);

  

