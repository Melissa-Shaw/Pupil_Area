% load spikestruct

function [spikestruct] = load_spikestruct(db,exp)
topDir = 'E:\bd126\Analysis\';
expDir = [topDir 'Exp ' num2str(exp) ' ' db(exp).animal ' ' db(exp).injection{1:end-1}];
load([expDir '\spikestruct']);
end