%run('E:\ms1121\Code\makedb_TCB2_MS.m');
makedb_TCB2_EDIT % NEED TO SORT OUT CHANGED VIDEO FILEPATHS FOR MANUAL REMOVAL SCRIP

% Extract pupil data
i=1;
for exp = Batch1PFC
  if strcmp(db(exp).animal,'M191023_A_BD')
    disp(['Exp: ' num2str(exp) ' Animal: ' db(exp).animal ' excluded.'])
  else
    [all_PA(i)] = create_PA(db,exp);
    disp(['Exp: ' num2str(exp) ' Animal: ' db(exp).animal ' loaded.'])
    i = i+1;
  end
end
clear i

% Align and trim data
[all_PA,start_drink_fr,end_drink_fr] = align_and_trimPA(all_PA);

% Separate into control and tcb
c = 1;
t = 1;
for i=1:numel(all_PA)
  if all_PA(i).dose == 0
    con_PA(c) = all_PA(i);
    c = c+1;
  else
    tcb_PA(t) = all_PA(i);
    t = t+1;
  end
end
clear c t

% create matrix of pupil area
[~,con_pupil_area] = find_mean_freq(con_PA,'pup_area');
[~,tcb_pupil_area] = find_mean_freq(tcb_PA,'pup_area');

%% Plot mean pupil area
figure
tiledlayout(1,2)
ax1 = nexttile;
stdshade(con_pupil_area,0.4,'k'); % plots mean with standard deviation in shaded region
xline(start_drink_fr,'LineWidth',1);
ylabel('Pupil Area (mm^2)');
xlabel('Frame')
title('Control')
box off
ax2 = nexttile;
stdshade(tcb_pupil_area,0.4,'r'); % plots mean with standard deviation in shaded region
xline(start_drink_fr,'LineWidth',1);
ylabel('Pupil Area (mm^2)');
xlabel('Frame')
title('TCB-2')
box off
linkaxes([ax1 ax2],'xy');
ylim([0 3])

%% Plot boxplot of pupil area pre v post drinking
gap = 5*60*24; % frame gap of approx 5 mins (5*60sec*24FPS)
section = 10*60*24; % section time frame of approx 10 mins (10*60sec*24FPS)
pre_bounds = [start_drink_fr-gap-section start_drink_fr-gap];
post_bounds = [end_drink_fr+gap end_drink_fr+gap+section];

con_pre = nanmean(con_pupil_area(:,pre_bounds(1):pre_bounds(2)),2);
con_post = nanmean(con_pupil_area(:,post_bounds(1):post_bounds(2)),2);
con_perc_change = ((con_post-con_pre)./con_pre)*100;
tcb_pre = nanmean(tcb_pupil_area(:,pre_bounds(1):pre_bounds(2)),2);
tcb_post = nanmean(tcb_pupil_area(:,post_bounds(1):post_bounds(2)),2);
tcb_perc_change = ((tcb_post-tcb_pre)./tcb_pre)*100;

figure
[p_rank_perc_change] = boxplot_conVtcb(con_perc_change',tcb_perc_change','Pupil Area',{'Control' 'TCB-2'});


%% Plot pupil area with population rate

e = 1;
figure
plot_single_recording(tcb_PA(e).pup_area,tcb_PA(e).populationrate,tcb_PA(e).fTimes_ms);
figure
plot_single_recording(con_PA(e).pup_area,con_PA(e).populationrate,con_PA(e).fTimes_ms);

function plot_single_recording(pup_area,populationrate,fTimes_ms)

  pop_rate = populationrate(fTimes_ms);
  pop_rate = double(pop_rate);
  
  if numel(pup_area)~=numel(pop_rate)
    disp('Pupil area and population rate do not match.')
  else
    % plot pupil area
    nexttile
    plot(pup_area)
    ylabel('Pupil Area (mm^2)')
    xlabel('Frame')
    box off

    % z-score area and pop rate for comparison
    pup_area_z = standardise_data(pup_area);
    pop_rate_z = standardise_data(pop_rate);

    % plot correlation with pop rate
    nexttile
    scatter(pup_area_z,pop_rate_z);
    xlabel('Pupil Area')
    ylabel('Population Rate')
    xline(0);
    yline(0);
    %ylim([-10 10])
    %xlim([-10 10])
    box off

    % plot area with pop rate
    nexttile
    plot(pop_rate_z);
    hold on
    plot(pup_area_z);
    hold off
    xlabel('Frame')
    ylabel('z-score')
    legend({'Population Rate' 'Pupil Area'})
    box off
  end
end
