function plot_tiled_pupil_area(db,EXP,method) % method = 1 for calc pupil area from DLC output, method = 2 for load pupil area from spikestruct

figure
tiledlayout('flow')
axs = [];

for exp = EXP
  % check for exclusions
  [exclude] = check_for_exclusions(db,exp);
  
  if exclude == false
    if method == 1
      % calc pupil area from filtered DLC csv output
      if exp >= 82 && exp <=92
       mirror = 1;
      else
       mirror = 0;
      end
      
      pup_area = [];
      for v = 1:numel(db(exp).pupil)
        [~,area] = calcPupilArea(db(exp).pupil{v},mirror);
        pup_area = [pup_area;area];
      end
    elseif method == 2
      % load pupil area from spikestruct
      %[spikestruct] = load_spikestruct(db,exp);
      file_path = ['R:\Neuropix\ms1121\Analysis Testing\Exp_' num2str(exp) '_' db(exp).animal '_' db(exp).date '\spikestruct'];
      load(file_path);
      pup_area = spikestruct.pup_area;
      %cond_markers = [];
      %for c = 1:numel(spikestruct.frameTimes)
      %  cond_markers = [cond_markers spikestruct.frameTimes{c}(1)]; % start frame times of each condition
      %end
      %cond_markers = (cond_markers-cond_markers(1)+1)./1000; % zero timings to start at frame 1
    else
      disp('Need to select method to get pupil area: 1 = calc from DLC, 2 = load from spikestruct')
    end
    % plot pupil area
    ax = nexttile;
    plot(pup_area)
    ylabel('Pupil Area (mm^2)')
    xlabel('Frame')
    %for c = 1:numel(cond_markers)
    %  xline(cond_markers(c));
    %end
    title([num2str(exp) ' ' db(exp).animal ' ' db(exp).date])

    axs = [axs ax];
  end
end

linkaxes(axs,'xy');
%ylim([0 5])

end