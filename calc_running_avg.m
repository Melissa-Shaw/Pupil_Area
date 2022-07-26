%% running average
  % inputs --> data and size of datapoint window to be averaged

function [run_avg] = calc_running_avg(datafile,window)   
    trim_data = datafile(1:floor(numel(datafile)/window)*window); % trim to a length thats a multiple of the window required
    run_avg = NaN(1,numel(trim_data)/window); % create NaN array of size
    a = 1; % starting index point
    for i=1:numel(run_avg)
      b = a+window-1; % end index point
      M = nanmean(trim_data(a:b)); % mean for window
      run_avg(i) = M;
      a = b+1;
    end
    if isnan(run_avg)
      disp('NaN mean values present') % marking in case any windows were not calculated
    end
end
