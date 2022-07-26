function [exclude] = check_for_exclusions(db,exp)

exclude = false;

excluded_recordings = {'M191023_A_BD','131119';... % 52
                       'M191023_A_BD','191119';... % 53
                       'M200312_A_BD','260320';... % 62
                       'M200826_C_BD','160920';... % 74
                       'M200826_C_BD','170920';... % 76
                       'M200826_D_BD','230920';... % 80
                       'M201008_C_BD','221020'}; % 84

for r = 1:size(excluded_recordings,1)
  if strcmp(db(exp).animal,excluded_recordings(r,1)) & strcmp(db(exp).date,excluded_recordings(r,2))
    exclude = true;
    disp(['Exp: ' num2str(exp) ' ' db(exp).animal ' ' db(exp).date ' excluded. Frame mismatch or no pupil data.']);
  end
end

end