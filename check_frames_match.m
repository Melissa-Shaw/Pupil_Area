function [fTimes] = check_frames_match(db,exp,csvfile,cond)
 
  [spikestruct] = load_spikestruct(db,exp);
  fTimes = cell2mat(spikestruct.frameTimes(cond));
  
  dlcData = readtable(csvfile);
  if verLessThan('matlab', '9.8')
    dlcCoordData = str2double(table2array(dlcData(3:end,:)));
  else 
    dlcCoordData = str2double(table2array(dlcData)); % later version autocorrects headers
  end
  
  if numel(fTimes) ~= size(dlcCoordData,1)
    disp(['NOTE: Frames do not match: Exp: ' num2str(exp) ' ' db(exp).animal ' ' db(exp).date ' Cond: ' num2str(cond)])
  else
    disp(['Frames match: Exp: ' num2str(exp) ' ' db(exp).animal ' ' db(exp).date ' Cond: ' num2str(cond)])
  end
  
end