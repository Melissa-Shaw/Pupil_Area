%run('E:\ms1121\Code\makedb_TCB2_MS.m');
makedb_TCB2_EDIT % NEED TO SORT OUT CHANGED VIDEO FILEPATHS FOR MANUAL REMOVAL SCRIPT

tcb = [48 51 53 54 57 61 66];
con = [49 50 52 55 56 60 68]; 

[tcb_PA] = find_pupil_area(db,tcb);
[con_PA] = find_pupil_area(db,con);

%%
figure
plot_pupil_area(tcb_PA,48);
figure
plot_pupil_area(tcb_PA_g,48);
figure
plot_pupil_area(tcb_PA_s,48);

%%
figure
tiledlayout(1,2)
ax1 = nexttile;
pupil_area = table2array(MEYE_PA(:,3));
plot(pupil_area);
ax2 = nexttile;
plot([tcb_PA_s(1).pre;tcb_PA_s(1).post]);
linkaxes([ax1 ax2],'xy');

%%
figure
tiledlayout(1,2)
ax1 = nexttile;
plot_pupil_area(tcb_PA_s,48);
ax2 = nexttile;
plot_pupil_area(con_PA_s,49);
linkaxes([ax1 ax2],'xy')

% LOCAL FUNCTIONS
function [PA] = find_pupil_area(db,exp)
  i=1;
  %gaus = gausswin(24)/sum(gausswin(24)); % guassian filter
  for e = exp
    pre = [];
    post = [];
    if numel(db(e).pupil)==2
      [pre, ~] = calcPupilArea(db(e).pupil{1});
      [post, ~] = calcPupilArea(db(e).pupil{2});
      %pre = pre(1:24:end);
      %post = post(1:24:end);
      %[pre] = calc_running_avg(pre,24);
      %[post] = calc_running_avg(post,24);
      %pre = nanconv(pre,gaus');
      %post = nanconv(post,gaus');
    end
    PA(i).exp = e;
    PA(i).pre = pre;
    PA(i).post = post;
    i=i+1;
  end
end

function plot_pupil_area(PA,e)
  for i=1:numel(PA)
    if PA(i).exp == e
      last_pre = numel(PA(i).pre);
      fullPA = [PA(i).pre;PA(i).post];
      plot(fullPA)
      xline(last_pre);
    end
  end
  xlabel('Frame')
  ylabel('Pupil Area (px^2)')
  box off
end
  
function plot_pupil_area_all(PA)
  figure
  tiledlayout(1,2)
  ax1 = nexttile;
  plot(PA(1).pre)
  hold on
  for i = 2:numel(PA.pre)
    plot(PA(i).pre)
  end
  ax2 = nexttile;
  plot(PA(1).post)
  hold on
  for i = 2:numel(PA.post)
    plot(PA(i).post)
  end
  linkaxes([ax1 ax2],'xy');
  xlabel('Frame');
  ylabel('Pupil Area (px)');
  box off
end
