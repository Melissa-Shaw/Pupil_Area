%run('E:\ms1121\Code\makedb_TCB2_MS.m');
makedb_TCB2_EDIT % NEED TO SORT OUT CHANGED VIDEO FILEPATHS FOR MANUAL REMOVAL SCRIPT


plot_tiled_pupil_area(db,Batch1PFC,1);

plot_tiled_pupil_area(db,Batch2PFC,1);

%%
Batch1PFC_edit = [Batch1PFC(1:4) Batch1PFC(7:12)]; % exclude 52 and 53

figure
tiledlayout('flow')
for exp = Batch1PFC_edit
  [spikestruct] = load_spikestruct(db,exp);
  pup_area = spikestruct.pup_area;
  %pup_area = [];
  %for v = 1:numel(db(exp).pupil)
  %  [~,area] = calcPupilArea(db(exp).pupil{v});
  %  pup_area = [pup_area;area];
  %end
  pop_rate = spikestruct.populationrate;
  pup_area = pup_area';
  fTimes = [];
  for c = 1:numel(spikestruct.frameTimes)
    fTimes = [fTimes round(spikestruct.frameTimes{c})'];
  end

  pup_area_full = zeros(1,numel(pop_rate));
  pup_area_full(fTimes) = pup_area;
  pup_area_full = nanconv(pup_area_full,gausswin(100)');
  
  nexttile
  crosscorr(pup_area_full, double(pop_rate), 1000);
  title([db(exp).animal ' ' db(exp).date]);
end
