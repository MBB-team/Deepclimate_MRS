function [exitflag,timings] = NS_DEEPCLIMATE_nswitch(window,AllData)
    % Script to run the training day for Task switching and n back and calibrates the choice tasks.
% Based on O_01_training_day_v03.m from FatStim.
%
% Antonius Wiehler <antonius.wiehler@gmail.com>
% Created:  2017-04-21
% Modified: 2017-05-16
% Modified: 2022-10-31 by Shruti Naik (shrutinaik.info@gmail.com)

pr = [];  % anything parameter related
tm = [];  % anything timing related
tr = [];  % anything trial related

pr.debug                        = 0;  % PTB debug configuration1
pr.eye_tracking.on              = 0;  % do we want to record eye tracking?
                                      % We do not want eye tracking for
                                      % training.

pr.condition = 1;                               
                                      
pr.path.meta                    = AllData.path.meta;
pr.path.nswitch                 = AllData.path.nswitch;
pr.path.rating                  = AllData.path.rating;

% We don't use the breaks
%pr.time.break_duration          = 2;  % break duration in min(!)

pr.time.wait_task_reminder      = 1;  % how long do we want to wait after the task reminder n switch, n back, choice?


pr.nswitch.checkperformance     = 1;  % SN : after how many rounds do we want to check nswitch performance to reduce ISI
%pr.nback.checkperformance       = 1;  % SN : after how many rounds do we want to check nback performance


%% PREPARATIONS
% =========================================================================
[~, hostname]      = system('hostname'); % get the name of the PC
pr.hostname        = deblank(hostname); clear hostname;
pr.scriptname      = mfilename('fullpath');  % save the name of this script

pr.name            = AllData.name; % ask for intials
pr.subid           = AllData.ID; subid = pr.subid; % ask for sub ID

pr.group = AllData.task_group;

pr.timestamp       = datestr(now, 30); % start time
tm.start.all       = GetSecs;

pr.fname           = [num2str(pr.subid) '_' pr.name '_' pr.timestamp];
pr.savewhere       = [pr.path.meta 'meta_' mfilename '_' pr.fname];

tm.log = [];  % initialize log structure as empty

save(pr.savewhere, 'pr', 'tr', 'tm');  % save meta config


% %% TRAINING N SWITCH NS_Training_nswitch_v03
% % =========================================================================
tm.start.nswitch(1)    = GetSecs; % start time

pr.ptb.PTBwindow = window;

[pr,tm, exitflag] = NS_Training_nswitch_v03(pr, tm, 1, pr.nswitch.checkperformance); % Training nSwitch, difficulties from 1 to N
tr.nswitch.finished(1) = 1;  % set flag when training is finished
tm.finish.nswitch(1)   = GetSecs; % end time

save(pr.savewhere, 'pr', 'tr', 'tm');  % save calibration config

if(exitflag)
    tm.aborted.nswitch(1) = GetSecs;
    timings = BEC_Timekeeping('nswitch_start',[],tm.start.nswitch(1));
    timings = [timings BEC_Timekeeping('nswitch_aborted',[],tm.finish.nswitch(1))];
    return;
end

timings = BEC_Timekeeping('nswitch_start',[],tm.start.nswitch(1));
timings = [timings BEC_Timekeeping('nswitch_finish',[],tm.finish.nswitch(1))];


end  % function
