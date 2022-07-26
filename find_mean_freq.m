function [M,powerMat] = find_mean_freq(LFP_allNV,freq)
    powerMat = [];
    for i=1:numel(LFP_allNV)
      if strcmp(freq,'slow')
        LFPpower = LFP_allNV(i).slow;
      elseif strcmp(freq,'beta')
        LFPpower = LFP_allNV(i).beta;
      elseif strcmp(freq,'gamma')
        LFPpower = LFP_allNV(i).gamma;
      elseif strcmp(freq,'pup_area')
        LFPpower = LFP_allNV(i).pup_area;
      end
      powerMat = [powerMat; LFPpower];
    end
    M = nanmean(powerMat);
end