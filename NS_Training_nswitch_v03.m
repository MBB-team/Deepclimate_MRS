function [pr, tm, exitflag] = NS_Training_nswitch_v03(pr, tm , condition, checkperformance, comment)
% function [pr, tm] = NS_Training_nswitch_v03(name, subid, condition, checkperformance, comment)
%   This functions trains a subject in the n switch task.
%   calls n-switch -- IK ( from Blain 2016 )
%   revised 2017-01 by AW
%   condition 1 = training
%   condition 2 = reminder A: 2 blocks each, niveau is announced
%   condition 3 = reminder B: 1 block each, niveau unannounced, w subjective
%   diff rating
% Modified on 2022-10-05 by Shruti Naik <shrutinaik.info@gmail.com>
%% SET CONFIGURATION PARAMETERS
% =========================================================================


pr.debug                          = 0;  % activate s  PTB de bug  mo de
pr.conditions                     = {'training', 'reminder_A', 'reminder_B','execute'};
sessnum                           = 1;  % how many sessions? Training is increased blockwise

if pr.debug
    pr.crit                       = 0.5;  % debugging, put low threshold
else
    pr.crit                       = 0.9;  % 0.9 participants have to reach 90% correct to reach next round ( in training condition 1)
end

% switches
if condition == 1 % if this is training period (ie subject have never done the task)
    pr.switches = [2 4 6 9 12]; %[0 1:2:11 12];
elseif condition == 2  % if we are in reminder A condition (difficulty is announced)
    pr.switches = [2 4 6 9 12];  % 2:2:12;  % switches we want to use for the reminder condition
    pr.switches = [0 pr.switches(randperm(length(pr.switches)))]; %random but always present zero as the first one
elseif condition == 3  % if we are in reminder B condition (difficulty NOT announced, subj diff rating follows)
    pr.switches = [0 1:2:12 12];  % switches we want to use for the reminder condition
    pr.switches = pr.switches(randperm(length(pr.switches)));
end

pr.time.ISI                       = 0.8;
pr.time.instructions              = [0.15 0.5];  % waiting interval at instructions in s
pr.time.after_display_performance = 1.5;  % how long to wait after performance display
pr.time.show_task_reminder        = 1.5;  % how long to show the reminder before task bloc?

pr.maxblocks = 5;   %How many blocks do we want to run at each niveau


%% SETUP PSYCHTOOLBOX
% =========================================================================
pr.ptb = O_open_screen_v02(pr.debug,pr.ptb.PTBwindow);
% save details
% -------------------------------------------------------------------------

pr.scriptname       = mfilename('fullpath');  % save the name of this script
pr.checkperformance = checkperformance;
pr.timestamp        = datestr(now, 30);  % date and clock at start of experiment

rng('shuffle');  % reset rng to a seed based on current time


blocknum     = 0;
rest         = 0;


%% run two short blocs of pre-practice for green and red
% =========================================================================

if condition == 1 %if this is training period (ie subject have never done the task)
    
    gr = randperm(2);
    
    for g = 1 : 2
        [nsprac,~,~,exitflag] = NS_task_nswitch_v03(pr, tm, 'pre-practice', 1, 1, 1.2, 990 + gr(g), []);
        acc = nanmean(nsprac.meanperf(1));  % mean performance in previous run
        text = sprintf('Performance = %.2f %%', acc * 100);  % display performance
        DrawFormattedText(pr.ptb.PTBwindow, text, 'center', 'center', [255, 255, 255]);
        Screen('Flip', pr.ptb.PTBwindow);
        WaitSecs(pr.time.after_display_performance);
        Screen('Flip', pr.ptb.PTBwindow);
    end
    
end
YES = 1; NO = 0;  % Define trial stages


%% RUN TASK
% =========================================================================

for difficulty = 1 : length(pr.switches)
    trainingdone = NO;
    blocknum = 0;
    thisdifficulty = 0;
    while trainingdone == NO
        
        blocknum = blocknum + 1;
        thisdifficulty = thisdifficulty + 1;
      
        
        % start slow for the first few blocks defined with checkperformance and then increase the speed in training
        if thisdifficulty < checkperformance && condition ==1
            ISI = 1.25;
        else
            ISI = pr.time.ISI;
        end
        
        
        %% run 1 block of 30 s
        [ns,~,~,exitflag] = NS_task_nswitch_v03(pr, tm, pr.conditions{condition}, sessnum, blocknum, pr.time.ISI, pr.switches(difficulty),[]);
        acc(blocknum) = nanmean(ns.meanperf(sessnum, blocknum));
        if(exitflag)
            return;
        end
        % give feedback for performance
        text = sprintf('Performance = %.2f %%', acc(blocknum) * 100);  % display performance
        DrawFormattedText(pr.ptb.PTBwindow, text, 'center', 'center', [255,255,255]);
        Screen('Flip', pr.ptb.PTBwindow);
        WaitSecs(3);
        Screen('Flip', pr.ptb.PTBwindow);
           
        if  blocknum < pr.maxblocks %subjects have not done maxblocks in this niveau
                trainingdone = NO;
        else %training for a difficulty level is done when 5 blocks are reached.
                        trainingdone = YES;                       
                   %     DrawFormattedText(pr.ptb.PTBwindow,['Fin de l''',pr.ptb.accent.entrainement,' au niveau ',num2str(pr.switches(difficulty))],'center','center', [255,255,255]);
                        Screen('Flip', pr.ptb.PTBwindow);
                        WaitSecs(0.5);
                        Screen('Flip', pr.ptb.PTBwindow);       
        end
    end %training done==NO
    
    %if condition == 1  % show end of training screen
    %    if difficulty==length(pr.switches)
    %        DrawFormattedText( pr.ptb.PTBwindow, ['Appuyez sur la touche droit pour terminer l''',pr.ptb.accent.entrainement,'.'], 'center','center', [255,255,255]);
    %    else
    %        DrawFormattedText( pr.ptb.PTBwindow, ['Appuyez sur la touche droit pour continuer au niveau ',num2str(pr.switches(difficulty+1))], 'center','center', [255,255,255]);
    %    end
    %    Screen('Flip',pr.ptb.PTBwindow);
    %    [secs, keyCode, deltaSecs] = KbWait(-1, 2);
    %    if keyCode(pr.ptb.rightKey) %continue
    %        exitflag = 0;
    %        continue; 
    %    end
    %end   % condition 1
end

%% Finish

%if condition == 1
%    question     = pr.ptb.accent.question(1:4,:); %3
    %questionname = {'Fatigue','Stress','Hunger'};
%    questionname = {'Fatigue','Stress','Hunger','Motiv'};
%    O_Rating_v02(['training_Nswitch_finish_niveau_',num2str(pr.switches(difficulty))], pr, tm, question, questionname);
%end  % if condition 1
end  % function
