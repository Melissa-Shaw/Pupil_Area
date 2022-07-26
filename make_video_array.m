
run('E:\ms1121\Code\makedb_TCB2_MS');

%EXP = [Batch1PFC 66 68];
EXP = Batch2PFC;

videos = {};
for exp = EXP
  if strcmp(db(exp).animal,'M200312_A_BD')
    disp([db(exp).animal ' excluded due to missing videos.']);
  elseif strcmp(db(exp).animal,'M200312_B_BD')
    disp([db(exp).animal ' requires training set Pupil_Tracking-MS-2021-04-22.'])
  elseif strcmp(db(exp).animal,'M201008_A_BD')||strcmp(db(exp).animal,'M201008_B_BD')||strcmp(db(exp).animal,'M201008_C_BD')
    for v = 1:numel(db(exp).pupil)
      file_path = db(exp).pupil{v};
      file_path = [file_path(1:56) file_path(45:55) '_mirror.mp4'];
      videos = [videos;file_path];
    end
  else
    for v = 1:numel(db(exp).pupil)
      file_path = db(exp).pupil{v};
      file_path = [file_path(1:56) file_path(45:55) '.mp4'];
      videos = [videos;file_path];
    end
  end
end

save('R:\Neuropix\md406\MS_DLC\videos.csv','videos');

clear exp EXP file_path v


