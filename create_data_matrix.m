function [dataMat] = create_data_matrix(data_struct,FOI) % FOI = feature of interest
    powerMat = [];
    for i=1:numel(data_struct)
      if startsWith(freq,'S')
        LFPpower = LFP_allNV(i).slow;
      end
      powerMat = [powerMat; LFPpower];
    end
end