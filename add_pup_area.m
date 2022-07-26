
function [spikestruct] = add_pup_area(db,exp,save_file) % input save_file as true if want to save spikestruct with new field

[exclude] = check_for_exclusions(db,exp);

if exclude == false
    % load spikestruct
    topDir = 'E:\bd126\Analysis\';
    expDir = [topDir 'Exp ' num2str(exp) ' ' db(exp).animal ' ' db(exp).injection{1:end-1}];
    load([expDir '\spikestruct']);

    % get frame time stamps
    fTimes_ms = [];
    for c = 1:numel(spikestruct.frameTimes)
      fTimes_ms = [fTimes_ms;spikestruct.frameTimes{c}];
    end
    fTimes_ms = round(fTimes_ms);

    % calc pupil area from filtered DLC csv output
    if exp >= 82 && exp <=92
      mirror = 1;
    else
      mirror = 0;
    end
    
    pup_area = [];
    for v = 1:numel(db(exp).pupil)
      [~,area] = calcPupilArea(db(exp).pupil{v},mirror);
      [area] = manual_removal(db(exp).pupil{v},area); % NaN values on set videos if required
      pup_area = [pup_area;area];
    end

    % check number of frames match
    if numel(fTimes_ms)~= numel(pup_area)
      disp(['Exp: ' num2str(exp) ' Number of frames do not match.'])
    else
      spikestruct.pup_area = pup_area;
      % save updated spikestruct
      if save_file==true
        disp(['Exp: ' num2str(exp) ' saving spikestruct...'])
        file_path = ['E:\ms1121\Analysis Testing\Exp_' num2str(exp) '_' db(exp).animal '_' db(exp).date '\spikestruct'];
        %file_path = [expDir '\spikestruct'];
        save(file_path,'spikestruct','-v7.3');
      end
    end
end

end