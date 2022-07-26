run('E:\ms1121\Code\makedb_TCB2_MS');

% set empty arrays for grouped analysis
high_mean = [];
low_mean = [];
%pup_area_tcb = {};
%pup_area_con = {};
i = 1;

% set exp
plot_figures = true;
for exp = AllPFC

% check that there is frame matched pupil data
[exclude] = check_for_exclusions(db,exp);

if exclude ~=true
  
  % load spikestruct
  file_path = ['E:\ms1121\Analysis Testing\Exp_' num2str(exp) '_' db(exp).animal '_' db(exp).date '\spikestruct'];
  load(file_path);
  
  % extract relevant data
  pup_area = spikestruct.pup_area';
  pop_rate = spikestruct.populationrate;
  fTimes = [];
  for c = 1:numel(spikestruct.frameTimes)
    fTimes = [fTimes round(spikestruct.frameTimes{c})'];
  end
  pop_rate_fr = pop_rate(fTimes);
  if numel(pup_area) == numel(fTimes)
    num_frames = numel(pup_area);
  else
    disp('NOTE: Frames do not match');
  end
  pop_rate_fr_bins = calc_running_avg(pop_rate_fr,10);
  pup_area_bins = calc_running_avg(pup_area,10);
  cut_off = nanmean(pup_area_bins);
  
  if plot_figures == true
    % set up figure
    figure
    tiledlayout(2,2)

    % plot pupil area
    nexttile
    plot(pup_area);
    ylabel('Pupil Area');
    xlabel('Frame');

    % plot population rate with pupil area for first 1000fr
    nexttile
    plot(pop_rate_fr);
    hold on
    plot(pup_area);
    hold off
    xlabel('Frame');
    legend('pop rate fr','pup area');
    xlim([0 10000]);

    % plot population rate bins of 10 frames with high and low pupil area
    %pop_rate_fr_bins = calc_running_avg(pop_rate_fr,10);
    %pup_area_bins = calc_running_avg(pup_area,10);
    %cut_off = nanmean(pup_area_bins);

    ax2 = nexttile;
    bar(pop_rate_fr_bins(pup_area_bins<cut_off));
    yline(nanmean(pop_rate_fr_bins(pup_area_bins<cut_off)));
    title('Low Pupil Area');
    ylabel('Mean Population Rate');
    box off
    ax3 = nexttile;
    bar(pop_rate_fr_bins(pup_area_bins>cut_off));
    yline(nanmean(pop_rate_fr_bins(pup_area_bins>cut_off)));
    title('High Pupil Area');
    ylabel('Mean Population Rate');
    box off
    linkaxes([ax2 ax3],'y');
  end

  % extract data for grouped analysis
  if db(exp).dose > 0
    pup_area_tcb{i} = pup_area;
  else
    pup_area_con{i} = pup_area;
  end
  i = i+1;
  high_mean = [high_mean nanmean(pop_rate_fr_bins(pup_area_bins>cut_off))];
  low_mean = [low_mean nanmean(pop_rate_fr_bins(pup_area_bins<cut_off))];
  
  
end

end

figure
scatter(low_mean,high_mean);
xlabel('Low pupil area population rate');
ylabel('High pupil area population rate');
p = ranksum(low_mean,high_mean);
title(['p = ' num2str(p)]);
refline([1,0]);

  