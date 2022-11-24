function [ns, eyeTrackdata, log, exitflag] = NS_task_nswitch_v03(pr, tm, condition, sessnum, blocknum, ISI, switches, eyeTrackdata)
%  Task Switch, need to enter 'switches' to specify  difficulty level - IK 2016, from Blain's MetaTaskSwitchingHardET_metabo_ECG
%  revised 2017-02 Antonius Wiehler <antonius.wiehler@gmail.com>


%% PREPARATIONS
% =========================================================================

ns.lblocs = 24;  % block length

%load the right file to update data
searchstring = sprintf('%snswitch_%s_%s_sess_%03i*.mat',pr.path.nswitch , condition, pr.fname, sessnum);
file = dir(searchstring);

if ~isempty(file)
    last1 = file(end).name;
    load([pr.path.nswitch, last1]);

else
    
    sessmax  = 10; % maximum number of sessions we expect
    blockmax = 200; % maximum number of sessions we expect
    trialmax = max(ns.lblocs); % maximum number of trials we expect
    
    ns.indexletter  = nan(sessmax, blockmax, trialmax);  % 10 sessions, 200 blocks, 24 letters, to be save
    ns.colortype    = nan(sessmax, blockmax, trialmax);
    ns.trial_onset  = nan(sessmax, blockmax, trialmax);
    ns.trial_end    = nan(sessmax, blockmax, trialmax);
    ns.resp         = nan(sessmax, blockmax, trialmax);
    ns.RT           = nan(sessmax, blockmax, trialmax);
    ns.perf         = nan(sessmax, blockmax, trialmax);
    
    ns.tm_when_finished = nan(sessmax, blockmax);
    ns.tm_blockstart    = nan(sessmax, blockmax);
    ns.tm_blockend      = nan(sessmax, blockmax);
    ns.durationblock    = nan(sessmax, blockmax);
    ns.meanperf         = nan(sessmax, blockmax);
    ns.fastperf         = nan(sessmax, blockmax);
    ns.meanRT           = nan(sessmax, blockmax);
    ns.difficulty       = nan(sessmax, blockmax);
    ns.nbvoymaj         = nan(sessmax, blockmax);
    ns.nbvoymin         = nan(sessmax, blockmax);
    ns.nbconsmin        = nan(sessmax, blockmax);
    ns.nbconsmaj        = nan(sessmax, blockmax);
end

if isfield(tm, 'log')
    log = tm.log; % copy log for this function
else
    log = [];
end

ns.timestamp = datestr(now, 30);
savewhere = sprintf('%snswitch_%s_%s_sess_%03i.mat',pr.path.nswitch , condition, pr.fname, sessnum);

%% TASK SWITCHING
% =========================================================================

if switches == 991 %first  is practice with slow RT, 1 bloc each of green and red
    colortype = 1 * ones(1, ns.lblocs);
elseif switches == 992
    colortype = 2 * ones(1, ns.lblocs);
elseif switches == 0
    colortype = NS_randcolortype_free(ns.lblocs,switches);
else
    colortype = [1 1 2];
    while sum(colortype == 1) ~= sum(colortype == 2)
        colortype = NS_randcolortype_free(ns.lblocs, switches);
    end
end

ns.tm_startsess(sessnum, blocknum) = GetSecs;
indexletter = NS_SequenceOfLetterTS(ns.lblocs);

% instructions
% group1 casse=rouge, Maj = left, Consonant = left
% group2 casse=vert, Min = left, Voyelle = left
ins = {'BECHAMEL/Stimuli/nswitch/Slide1.TIF', 'BECHAMEL/Stimuli/nswitch/Slide2.TIF'};

theImageLocation = ins{pr.group};
theImage = imread(theImageLocation);
imageTexture = Screen('MakeTexture', pr.ptb.PTBwindow, theImage);
Screen('DrawTexture', pr.ptb.PTBwindow, imageTexture, [], [], 0);

Screen('Flip', pr.ptb.PTBwindow);
WaitSecs(pr.time.show_task_reminder);
Screen('Flip', pr.ptb.PTBwindow);
WaitSecs(pr.time.wait_task_reminder);
Screen('Flip', pr.ptb.PTBwindow);

[ns1, eyeTrackdata, log, exitflag] = NS_present_nswitch_v03(pr.group, pr.ptb, log, colortype, indexletter, ISI, eyeTrackdata);

if(exitflag)
    clear Screen;
    ns.tm_blockstart(sessnum, blocknum)    = ns1.tm_blockstart;
    ns.tm_blockend(sessnum,blocknum)       = nan;
    ns.difficulty(sessnum, blocknum)       = switches;
    ns.indexletter(sessnum, blocknum, 1 : ns.lblocs) = indexletter;
    ns.colortype(sessnum, blocknum, 1 : ns.lblocs)   = colortype;
    ns.fname         = pr.fname;
    ns.condition     = condition;
    %many per sessnum
    ns.indexletter(sessnum, blocknum, 1 : ns.lblocs) = indexletter;
    ns.colortype(sessnum, blocknum, 1 : ns.lblocs)   = colortype;

    ns.fname         = pr.fname;
    ns.condition     = condition;
    save(savewhere, 'ns');
    return;
end

%one per sessnum
ns.tm_when_finished(sessnum, blocknum) = GetSecs;
ns.tm_blockstart(sessnum, blocknum)    = ns1.tm_blockstart;
ns.tm_blockend(sessnum, blocknum)      = ns1.tm_blockend;
ns.durationblock(sessnum, blocknum)    = ns1.durationblock;
ns.meanperf(sessnum, blocknum)         = nanmean(ns1.perf);
ns.fastperf(sessnum, blocknum)         = nanmean(ns1.perf(ns1.RT <= 0.8));
ns.meanRT(sessnum, blocknum)           = nanmean(ns1.RT(ns1.perf == 1));
ns.nbvoymaj(sessnum, blocknum)         = ns1.nbvoymaj;
ns.nbvoymin(sessnum, blocknum)         = ns1.nbvoymin;
ns.nbconsmin(sessnum, blocknum)        = ns1.nbconsmin;
ns.nbconsmaj(sessnum, blocknum)        = ns1.nbconsmaj;
ns.difficulty(sessnum, blocknum)       = switches;

%many per sessnum
ns.indexletter(sessnum, blocknum, 1 : ns.lblocs) = indexletter;
ns.colortype(sessnum, blocknum, 1 : ns.lblocs)   = colortype;
ns.trial_onset(sessnum, blocknum, 1 : ns.lblocs) = ns1.trial_onset;
ns.trial_end(sessnum, blocknum, 1 : ns.lblocs)   = ns1.trial_end;
ns.resp(sessnum, blocknum, 1 : ns.lblocs)        = ns1.resp;
ns.RT(sessnum, blocknum, 1 : ns.lblocs)          = ns1.RT;
ns.perf(sessnum, blocknum, 1 : ns.lblocs)        = ns1.perf;


ns.fname         = pr.fname;
ns.condition     = condition;
ns.letters       = ns1.letters;
ns.colors        = ns1.colors;
ns.ITI           = ns1.ITI;
save(savewhere, 'ns');



% print details to console
fprintf('Completed NSWITCH - session %02i - block %02i - difficulty %02i - performance %.2f\n', sessnum, blocknum, switches, nanmean(ns1.perf));

end  % end main function