function [area] = manual_removal(pupil_filepath,area)

if strcmp(pupil_filepath,'R:\Neuropix\Shared\Data\M200312_A_BD\270320\video_71662\video_71662DLC_resnet50_Pupil_TrackingApr22shuffle1_2400_filtered.csv')
  area(:) = NaN; % exp 64 M200312_A_BD 270320 video 4 - secretions
elseif strcmp(pupil_filepath,'R:\Neuropix\Shared\Data\M200312_A_BD\270320\video_73151\video_73151DLC_resnet50_Pupil_TrackingApr22shuffle1_2400_filtered.csv')
  area(:) = NaN; % exp 64 M200312_A_BD 270320 video 5 - squinting and secretions
elseif strcmp(pupil_filepath,'R:\Neuropix\Shared\Data\M200312_B_BD\270320\video_52652\video_52652DLC_resnet50_Pupil_TrackingApr22shuffle1_2400_filtered.csv')
  area(13376:13443) = NaN; % exp 66 M200312_B_BD 270320 video 5 - finger occlusion
  area(22673:end) = NaN; % exp 66 M200312_B_BD 270320 video 5 - secretions and squinting
elseif strcmp(pupil_filepath,'R:\Neuropix\Shared\Data\M201008_A_BD\281020\video_59149\video_59149_mirrorDLC_resnet50_FacePupil_TrackingApr29shuffle1_3000_filtered.csv')
  area(15851:end) = NaN; % exp 88 M201008_A 281020 video 4 - secretions
elseif strcmp(pupil_filepath,'R:\Neuropix\Shared\Data\M201008_A_BD\281020\video_60947\video_60947_mirrorDLC_resnet50_FacePupil_TrackingApr29shuffle1_3000_filtered.csv')
  area(:) = NaN; % exp 88 M201008_A 281020 video 5 - secretions
  %area(9840:end) = NaN; % exp 88 M201008_A 281020 video 5 - secretions
elseif strcmp(pupil_filepath,'R:\Neuropix\Shared\Data\M201008_B_BD\291020\video_46047\video_46047_mirrorDLC_resnet50_FacePupil_TrackingApr29shuffle1_3000_filtered.csv')
  area(14229:end) = NaN; % exp 90 M201008_B 291020 video 3 - secretions and squinting
elseif strcmp(pupil_filepath,'R:\Neuropix\Shared\Data\M201008_B_BD\291020\video_47167\video_47167_mirrorDLC_resnet50_FacePupil_TrackingApr29shuffle1_3000_filtered.csv')
  area(:) = NaN; % exp 90 M201008_B 291020 video 4 - squinting
elseif strcmp(pupil_filepath,'R:\Neuropix\Shared\Data\M201008_B_BD\291020\video_48676\video_48676_mirrorDLC_resnet50_FacePupil_TrackingApr29shuffle1_3000_filtered.csv')
  area(:) = NaN; % exp 90 M201008_B 291020 video 5 - squinting
elseif strcmp(pupil_filepath,'R:\Neuropix\Shared\Data\M201008_B_BD\301020\video_57768\video_57768_mirrorDLC_resnet50_FacePupil_TrackingApr29shuffle1_3000_filtered.csv')
  area(:) = NaN; % exp 92 M201008_B 301020 video 5 - secretions and squinting
  %area(9173:end) = NaN; % exp 92 M201008_B 301020 video 5 - secretions and squinting
end


end