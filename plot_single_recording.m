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