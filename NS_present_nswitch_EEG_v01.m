function [ns1, eyeTrackdata, log] = NS_present_nswitch_EEG_v01(group, ptb, log, colortype, indexletter, ISI, eyeTrackdata)
% function [ns1, eyeTrackdata, log] = NS_present_nswitch_v03(group, ptb, log, colortype, indexletter, ISI, eyeTrackdata)
% Present N-switch -IK 2016, from Blain TaskSwitchingHardET_metabo_ECG, but
% includes easy version too!
%  revised 2017-02 Antonius Wiehler <antonius.wiehler@gmail.com>

% Markers 
% 42 = draw letter
% 43 = wait for resp
% 45 = Resp
%% PREPARATIONS
% ===================================================================
cenir_hostname = 'DELLFBA7';

trigger_duration_s = .005;

ns1.letters     = ['A' 'E' 'I' 'O' 'U' 'Y' 'a' 'e' 'i' 'o' 'u' 'y'...
    'B' 'C' 'G' 'K' 'M' 'P' 'b' 'c' 'g' 'k' 'm' 'p'];

ns1.colors      = [ptb.color.green; ptb.color.lum_matched.red; ptb.color.white]; %green red white

ns1.ISI     = ISI;
ns1.ITI     = 0.8;

gettime             = nan(size(colortype));
resp                = nan(size(colortype));
RT                  = nan(size(colortype));
perf                = nan(size(colortype));
gettimend           = nan(size(colortype));

Screen('TextSize', ptb.PTBwindow, ptb.fontsize.standard);
Screen('TextFont', ptb.PTBwindow, ptb.fontname.standard);

if ~isempty(eyeTrackdata)
    EyeTribeSetCurrentMark(1000000 * 4 + 100 * 0 + 1 * 5); % set marker : type - trial - mark
end

log = putLog(log, GetSecs, 'begin_nSwitch');

%% BEHAVIORAL TASK - LOOP LETTERS
% ===================================================================

ns1.tm_blockstart   = GetSecs;

for i_trial = 1 : length(colortype)
    
    Screen('TextSize', ptb.PTBwindow, ptb.fontsize.nswitch);
    Screen('TextFont', ptb.PTBwindow, ptb.fontname.nswitch);
    color_letter        = ns1.colors(colortype(i_trial), :);  % green or red
    letternow           = indexletter(i_trial);  % which letter (1:12 vowel, 13:24 cons; first and third 6 are Majuscule))
    letternowstring     = ns1.letters(letternow);  % which letter (1:12 vowel, 13:24 cons; first and third 6 are Majuscule))
    
    % RECORD EYE DATA
    % -----------------------------------------------------------------------
    if rem(i_trial, 8) == 0 %saves data every 8 letters
        if ~isempty(eyeTrackdata)
            [ retVal, dataEye, overFlow ] = EyeTribeGetDataSimple();
            eyeTrackdata = [eyeTrackdata; dataEye];
        else
            eyeTrackdata = [];
        end
    end
    
    % DRAW LETTER ON SCREEN
    % -----------------------------------------------------------------------
    DrawFormattedText(ptb.PTBwindow, letternowstring, 'center', 'center', color_letter);
    gettime(i_trial) = Screen('Flip', ptb.PTBwindow);
    
    SendTrigger( 42, trigger_duration_s );
    
    if ~isempty(eyeTrackdata)
        EyeTribeSetCurrentMark(1000000 * 4 + 100 * i_trial + 1 * 2); % set marker : type - trial - mark
    end
    
    log = putLog(log, gettime(i_trial), sprintf('NSwitch_StimOnset_%03i', i_trial));
    
    % WAIT FOR RESPONSE
    % -----------------------------------------------------------------------
    
    Timeout      = gettime(i_trial) + ns1.ISI;
    keyCode      = zeros(1, 256);
    
    RestrictKeysForKbCheck([ptb.leftKey ptb.rightKey ptb.abortKey]);  % onyl listen to the important keys
    
    while (GetSecs <= Timeout) && (sum(keyCode) ~=1)  % timeout after 5s
        [~, secs, keyCode] = KbCheck;
    end
    
    if ( GetSecs() <= Timeout )
 SendTrigger( 43, trigger_duration_s );
    end
    
    if ~isempty(eyeTrackdata)
        EyeTribeSetCurrentMark(1000000 * 4 + 100 * i_trial + 1 * 3); % set marker : type - trial - mark
    end
    
    log = putLog(log, secs, sprintf('NSwitch_Response_%03i', i_trial));
    
    % Record key response
    % -----------------------------------------------------------------------
    
    if keyCode(ptb.leftKey)
        resp(i_trial) = ptb.leftKey;
        RT(i_trial)   = secs - gettime(i_trial);
        
    elseif keyCode(ptb.rightKey)
        resp(i_trial) = ptb.rightKey;
        RT(i_trial)   = secs - gettime(i_trial);
        
    elseif keyCode(ptb.abortKey)  % if we want to stop the experiment
        sca;
        ShowCursor;
        break
        
    else
        resp(i_trial) = NaN;
        RT(i_trial)   = NaN;
    end
    
    WaitSecs(ns1.ISI - RT(i_trial));
    
    fliptime = Screen('Flip', ptb.PTBwindow);
   
    SendTrigger( 45, trigger_duration_s );
    
    if ~isempty(eyeTrackdata)
        EyeTribeSetCurrentMark(1000000 * 4 + 100 * i_trial + 1 * 5); % set marker : type - trial - mark
    end
    
    log = putLog(log, fliptime, sprintf('NSwitch_Jitter_%03i', i_trial));
    
    WaitSecs(ns1.ITI);
       
    if ~isempty(eyeTrackdata)
        EyeTribeSetCurrentMark(1000000 * 4 + 100 * i_trial + 1 * 1); % set marker : type - trial - mark
    end
    
    log = putLog(log, GetSecs, sprintf('NSwitch_EndofTrial_%03i', i_trial));
    
    RestrictKeysForKbCheck([]);  % stop listen only to the important keys
    
    % CALCULATE PERFORMANCE
    % -----------------------------------------------------------------------
    majusc=[1:6 13:18]; minusc=[7:12 19:24]; voyelle=1:12; consonne=13:24;
    
    if group == 1 % group 1 casse = rouge, Majuscule = press left, Consonant = press left
        if colortype(i_trial)==1 % vert= Tasche Phonetique; Consonant = press left
            if ismember(letternow,voyelle) && resp(i_trial)==ptb.rightKey %vowel is right
                perf(i_trial) = 1;
            elseif (ismember(letternow,voyelle) && resp(i_trial)==ptb.leftKey) || resp(i_trial)==0 %wrong
                perf(i_trial) = 0;
            elseif ismember(letternow,consonne) && resp(i_trial)==ptb.leftKey % consonant is left
                perf(i_trial) = 1;
            elseif (ismember(letternow,consonne) && resp(i_trial)==ptb.rightKey) || resp(i_trial)==0  %wrong
                perf(i_trial) = 0;
            else
                perf(i_trial) = 0;
            end
        elseif colortype(i_trial)==2 % rouge= Tasche Casse; Majuscule = press left
            if ismember(letternow,majusc) && resp(i_trial)==ptb.leftKey
                perf(i_trial) = 1;
            elseif (ismember(letternow,majusc) && resp(i_trial)==ptb.rightKey) || resp(i_trial)==0
                perf(i_trial) = 0;
            elseif ismember(letternow,minusc) && resp(i_trial)==ptb.rightKey
                perf(i_trial) = 1;
            elseif (ismember(letternow,minusc) && resp(i_trial)==ptb.leftKey) || resp(i_trial)==0
                perf(i_trial) = 0;
            else
                perf(i_trial) = 0;
            end
        end
        
    elseif group == 2 % group2 casse = vert, Minuscule = press left, Voyelle = press left
        
        if colortype(i_trial)==1 % vert = Tasche Casse; Minuscule = press left
            if ismember(letternow,majusc) && resp(i_trial)==ptb.rightKey %majuscule is right
                perf(i_trial) = 1;
            elseif (ismember(letternow,majusc) && resp(i_trial)==ptb.leftKey) || resp(i_trial)==0 %wrong
                perf(i_trial) = 0;
            elseif ismember(letternow,minusc) && resp(i_trial)==ptb.leftKey % consonant is left
                perf(i_trial) = 1;
            elseif (ismember(letternow,minusc) && resp(i_trial)==ptb.rightKey) || resp(i_trial)==0  %wrong
                perf(i_trial) = 0;
            else
                perf(i_trial) = 0;
            end
        elseif colortype(i_trial)==2 % rouge = Tasche Phonetique; Voyelle = press left
            if ismember(letternow,voyelle) && resp(i_trial)==ptb.leftKey
                perf(i_trial) = 1;
            elseif (ismember(letternow,voyelle) && resp(i_trial)==ptb.rightKey) || resp(i_trial)==0
                perf(i_trial) = 0;
            elseif ismember(letternow,consonne) && resp(i_trial)==ptb.rightKey
                perf(i_trial) = 1;
            elseif (ismember(letternow,consonne) && resp(i_trial)==ptb.leftKey) || resp(i_trial)==0
                perf(i_trial) = 0;
            else
                perf(i_trial) = 0;
            end
        end
    end  % if group
    
    gettimend(i_trial) = GetSecs;
    
end  % for loop letters

%% OUTPUT DATA
% ===================================================================

ns1.tm_blockend     = gettimend(end);
ns1.durationblock   = gettimend(end) - ns1.tm_blockstart;
ns1.trial_onset     = gettime;
ns1.trial_end       = gettimend;
ns1.resp            = resp;
ns1.RT              = RT;
ns1.perf            = perf;

% check proportion
nbvoymaj=0;
nbvoymin=0;
nbconsmin=0;
nbconsmaj=0;
for a=1:length(indexletter)
    if ismember(indexletter(a),intersect(majusc,voyelle))
        nbvoymaj=nbvoymaj+1;
    elseif ismember(indexletter(a),intersect(minusc,voyelle))
        nbvoymin=nbvoymin+1;
    elseif ismember(indexletter(a),intersect(majusc,consonne))
        nbconsmaj=nbconsmaj+1;
    elseif ismember(indexletter(a),intersect(minusc,consonne))
        nbconsmin=nbconsmin+1;
    end
end
ns1.nbvoymaj    = nbvoymaj;
ns1.nbvoymin    = nbvoymin;
ns1.nbconsmin   = nbconsmin;
ns1.nbconsmaj   = nbconsmaj;

% reset screen font to standard
Screen('TextSize', ptb.PTBwindow, ptb.fontsize.standard);
Screen('TextFont', ptb.PTBwindow, ptb.fontname.standard);

end  % end main function