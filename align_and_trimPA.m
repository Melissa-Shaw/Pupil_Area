function [PA,align_point,end_drinking] = align_and_trimPA(PA)

  start_drink_fr = NaN(1,numel(PA));
  length = NaN(1,numel(PA));
  end_drink_fr = NaN(1,numel(PA));

  % Trim start to align according to start of drinking
  for i=1:numel(PA)
    start_drink_fr(i) = PA(i).start_drink_fr;
  end

  align_point = min(start_drink_fr);

  for i=1:numel(PA)
    shift = start_drink_fr(i)-align_point;
    PA(i).aligned_fTime_marker = PA(i).fTime_marker-shift;
    PA(i).pup_area = PA(i).pup_area(shift+1:end);
    PA(i).fTimes_ms = PA(i).fTimes_ms(shift+1:end);
    
    length(i) = numel(PA(i).pup_area);
    end_drink_fr(i) = PA(i).aligned_fTime_marker(2);
  end
  
  % Trim end length to shortest recording
  trim_point = min(length);
  
  for i=1:numel(PA)
    PA(i).pup_area = PA(i).pup_area(1:trim_point);
    PA(i).fTimes_ms = PA(i).fTimes_ms(1:trim_point);
  end
  
  % Find mean end drinking frame
  end_drinking = nanmean(end_drink_fr);
  
end