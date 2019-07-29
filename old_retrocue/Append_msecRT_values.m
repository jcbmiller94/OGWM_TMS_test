function Append_msecRT_values(textfile, matfile, output_txt_file)
%% <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><> %%
% <><><><><>  Correct text files for subs without saved RTs   <><><><><> %
% <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><> %

load(matfile); % to get cursor_velocity cell array

% loop through cell array to generate array of raw output from cursor data
%   (# of samples collected) 

sample_counts = []; 
for i=1:size(cursor_velocity,1)
    for k=1:size(cursor_velocity,2)
    sample_counts = [sample_counts; length(cursor_velocity{i,k})];
    end
end

% multiply by 2 (500 Hz sampling ==> msec) 
msecRT = 2*sample_counts;
% convert ot cell in order to change vlaue of RTs = 2000 to 'Time-out' 
msecRT=num2cell(msecRT); 
for i=1:length(msecRT)
    if msecRT{i}==2000
        msecRT{i} = 'Time-out';
    end
end

% import data from text file, read out into cell array
txt=importfile(textfile);

for i=1:size(txt)
    %txt{i, 18} = msecRT{i}; % 18th column is msecRT time! 
    txt{i, 18} = msecRT{i};
end

% add labels to top row of cell array
labels = {'subject' 'session' 'target' 'block' 'trial' 'CurrentCondition' 'TrialType' 'CompType' 'CurrentSampleIndex_1' 'CurrentSampleIndex_2' 'CurrentSample_1' 'CurrentSample_2' 'CurrentCue' 'cueColor' 'correctResp' 'Resp' 'ACC' 'msecRT' 'move_init_msecRT' 'move_init_bound_msecRT' 'enter_box_msecRT' 'velocity_drop_msecRT' 'cueValidity' 'probe_loc' 'probeMatch' 'CurrentProbeSample' 'correctProbeResp' 'probeResp' 'probeACC' 'probemsecRT'}; 
%labels = {'subject' 'block' 'trial' 'CurrentCondition' 'TrialType' 'CompType' 'CurrentSampleIndex_1' 'CurrentSampleIndex_2' 'CurrentSample_1' 'CurrentSample_2' 'CurrentCue' 'cueColor' 'correctResp' 'Resp' 'ACC' 'msecRT' 'move_init_msecRT' 'move_init_bound_msecRT' 'enter_box_msecRT' 'velocity_drop_msecRT' 'cueValidity' 'probe_loc' 'probeMatch' 'CurrentProbeSample' 'correctProbeResp' 'probeResp' 'probeACC' 'probemsecRT'}; 
txt = vertcat(labels, txt); 
   
% save out text file 
dlmcell(output_txt_file, txt);

end
