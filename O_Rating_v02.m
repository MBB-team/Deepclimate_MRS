function [log] = O_Rating_v02(task, pr, tm, question, questionname, niveau)

% function []= O_Rating_v02(task, fname, ptb, question, questionname)
% Rating data, modified from Blain's--saves data, checks how many ratings
% have been done and save data as the next session number
% IK and AW

%% SET CONFIGURATION PARAMETERS
% =========================================================================
% set the size of the scale
sizeScale    = 0.6; % percentage of screen
lineWidthPix = 4; % set the line width
wait_time    = 0.15;  % wait between questions

if isfield(tm, 'log')
    log = tm.log; % copy log for this function
else
    log = [];
end

%% PREPARATIONS
% =========================================================================
savewhere = sprintf('%sratings_%s_%s.mat', pr.path.rating, pr.conditions{pr.condition}, pr.fname);

files = dir(savewhere);  % does previous rating exist?

% if file exists, load the file to update data
if ~isempty(files)
    last1 = files(size(files, 1)).name;
    load([pr.path.rating, last1]);
    new1  = size(rate.rating, 1) + 1;  % start new rating after the current one
else
    % if no file is found start at 1
    new1 = 1;
end




% set the size of the scale
scaleDimPix        = (sizeScale .* pr.ptb.screenXpixels) ./ 2;

% set coordinates
scaleXCoords       = [-scaleDimPix scaleDimPix 0 0];
scaleYCoords       = [0 0 0 0];
scaleXCoordsBeg    = [-scaleDimPix -scaleDimPix 0 0];
scaleYCoordsBeg    = [-20 20 0 0];
scaleXCoordsEnd    = [scaleDimPix scaleDimPix 0 0];
scaleYCoordsEnd    = [-20 20 0 0];
allcoordsH         = [scaleXCoords; scaleYCoords];
allcoordsVBeg      = [scaleXCoordsBeg; scaleYCoordsBeg];
allcoordsVEnd      = [scaleXCoordsEnd; scaleYCoordsEnd];





Screen('TextSize', pr.ptb.PTBwindow, pr.ptb.fontsize.standard);




% RATING BASICS
rate.fname{new1}                            = pr.fname;
rate.task{new1}                             = task;  % in which task are we
rate.question(new1, 1:size(question,1))     = question;
rate.questionname(new1, 1:size(question,1)) = questionname;
rate.nRate(new1)                            = size(question, 1);  % how many ratings to be done?
rate.start(new1, 1)                         = GetSecs;  % time of start
rate.when{new1}                             = datestr(now);  % what time is now
if exist('niveau', 'var') == 1
    rate.niveau(new1,1) = niveau; %record nswitch level
end



%% DO THE RATINGS
% =========================================================================
for i_r = 1 : rate.nRate(new1)
    
    % Draw the scale
    Screen('DrawLines', pr.ptb.PTBwindow, allcoordsH,    lineWidthPix, pr.ptb.color.text, [pr.ptb.screenXpixels/2, pr.ptb.screenYpixels/2]);
    Screen('DrawLines', pr.ptb.PTBwindow, allcoordsVBeg, lineWidthPix, pr.ptb.color.text, [pr.ptb.screenXpixels/2, pr.ptb.screenYpixels/2]);
    Screen('DrawLines', pr.ptb.PTBwindow, allcoordsVEnd, lineWidthPix, pr.ptb.color.text, [pr.ptb.screenXpixels/2, pr.ptb.screenYpixels/2]);
    
    % Draw the initial cursor position
    stepStartingPoint   = lineWidthPix;
    rangeStartingPoint  = [-scaleDimPix : stepStartingPoint : scaleDimPix];
    randomStartingPoint = randperm(length(rangeStartingPoint) - 4) + 2;
    randomStartingPoint = rangeStartingPoint(randomStartingPoint(1));
    scaleXCoordsRand    = [randomStartingPoint randomStartingPoint 0 0];
    scaleYCoordsRand    = [-20 20 0 0];
    allcoordsVRand      = [scaleXCoordsRand; scaleYCoordsRand];
    rangeCursorPosition = [-scaleDimPix : lineWidthPix : scaleDimPix];
    
    Screen('DrawLines', pr.ptb.PTBwindow, allcoordsVRand, lineWidthPix, pr.ptb.color.highlight, [pr.ptb.screenXpixels/2, pr.ptb.screenYpixels/2]);
    
    
    % Draw labels
    DrawFormattedText(pr.ptb.PTBwindow, question{i_r}, 'center', (pr.ptb.screenYpixels/2) * 0.75, pr.ptb.color.text);
    DrawFormattedText(pr.ptb.PTBwindow, '100 %', (1 + sizeScale) * (pr.ptb.screenXpixels/2)-20, (pr.ptb.screenYpixels/2)*1.1, pr.ptb.color.text);
    DrawFormattedText(pr.ptb.PTBwindow, '0 %', (1 - sizeScale) * (pr.ptb.screenXpixels/2), (pr.ptb.screenYpixels/2)*1.1, pr.ptb.color.text);
    
    % Flip to the screen
    vbl = Screen('Flip', pr.ptb.PTBwindow);
    rate.qtime0(new1, i_r) = vbl;  % for later precise flipping
    
    log = putLog(log, rate.qtime0(new1, i_r), 'show rating');
    
    
    % Change cursor position
    
    crit = 0;  % criterion for while loop
    nbofpressRating = 1;
    nextCursorPosition = [];
    KbReleaseWait;  % wait that all keys are released before start checking again. To avoid constant button presses. To continue, all buttons need to be released.
    
    while crit ~= 1
        
        [~, secs, keyCode, ~] = KbCheck;
        
        rate.resp(new1, i_r) = secs;  % record button press timing
        
        if keyCode(pr.ptb.leftKey) || keyCode(pr.ptb.rightKey)
            
            % Draw the scale
            Screen('DrawLines', pr.ptb.PTBwindow, allcoordsH,    lineWidthPix, pr.ptb.color.text, [pr.ptb.screenXpixels/2, pr.ptb.screenYpixels/2]);
            Screen('DrawLines', pr.ptb.PTBwindow, allcoordsVBeg, lineWidthPix, pr.ptb.color.text, [pr.ptb.screenXpixels/2, pr.ptb.screenYpixels/2]);
            Screen('DrawLines', pr.ptb.PTBwindow, allcoordsVEnd, lineWidthPix, pr.ptb.color.text, [pr.ptb.screenXpixels/2, pr.ptb.screenYpixels/2]);
            
            % Draw labels
            DrawFormattedText(pr.ptb.PTBwindow, question{i_r}, 'center', (pr.ptb.screenYpixels/2) * 0.75, pr.ptb.color.text);
            DrawFormattedText(pr.ptb.PTBwindow, '100 %', (1 + sizeScale) * (pr.ptb.screenXpixels/2)-20, (pr.ptb.screenYpixels/2)*1.1, pr.ptb.color.text);
            DrawFormattedText(pr.ptb.PTBwindow, '0 %', (1 - sizeScale) * (pr.ptb.screenXpixels/2), (pr.ptb.screenYpixels/2)*1.1, pr.ptb.color.text);
            
            
            if nbofpressRating == 1
                currentCursorIndex = find(rangeCursorPosition == randomStartingPoint);
            else
                currentCursorIndex = find(rangeCursorPosition == nextCursorPosition);
            end
            
            if keyCode(pr.ptb.leftKey) && (currentCursorIndex > 2)
                nbofpressRating = nbofpressRating + 1;
                nextCursorPosition = rangeCursorPosition(currentCursorIndex - 2);
                nextCursorPosition = max(nextCursorPosition, -scaleDimPix);
            elseif keyCode(pr.ptb.rightKey) && (currentCursorIndex < length(rangeCursorPosition) -1)
                nbofpressRating = nbofpressRating + 1;
                nextCursorPosition = rangeCursorPosition(currentCursorIndex + 2);
                nextCursorPosition = min(nextCursorPosition, scaleDimPix);
            end
            
            scaleXCoordsRating = [nextCursorPosition nextCursorPosition 0 0];
            scaleYCoordsRating = [-20 20 0 0];
            allcoordsVRating   = [scaleXCoordsRating;scaleYCoordsRating];
            Screen('DrawLines', pr.ptb.PTBwindow, allcoordsVRating, lineWidthPix, pr.ptb.color.highlight, [pr.ptb.screenXpixels/2, pr.ptb.screenYpixels/2]);
            
            % Flip to the screen
            vbl = Screen('Flip', pr.ptb.PTBwindow, vbl + 0.5 * pr.ptb.FlipInterval);
            
        end
        
        if keyCode(pr.ptb.returnKey) && nbofpressRating > 1  && (secs - rate.qtime0(new1, i_r)) > 0.5
            
            rate.RT(new1, i_r) = rate.resp(new1, i_r) - rate.qtime0(new1, i_r);  % response time
            
            if pr.eye_tracking.on
                EyeTribeSetCurrentMark(1000000 * 2 + 100 * i_r + 1 * 3); % set marker : type - trial - mark
            end
            
            log = putLog(log, rate.qtime0(new1, i_r), 'rating response');
            
            
            crit = 1;  % crterion for valid key press is reached
        end
    end
    
    listNbofpressRating = nbofpressRating;
    listRandomPosition  = 100 * find(rangeCursorPosition == randomStartingPoint) / length(rangeCursorPosition);
    listRating          = 100 * find(rangeCursorPosition == nextCursorPosition) / length(rangeCursorPosition);
    
    rate.numpress(new1, i_r)     = listNbofpressRating;
    rate.randposition(new1, i_r) = listRandomPosition;
    rate.rating(new1, i_r)       = listRating;
    
    save(savewhere, 'rate');  % save everything
    
    WaitSecs(wait_time);  % wait between questions
end  % for loop ratings

if size(question, 1)~=3 % to allow concatenating different rating data
    for fill=2:3
        rate.question{new1, fill}     = 'n/a';
        rate.questionname{new1, fill} = 'n/a';
        rate.numpress(new1, fill)     = nan;
        rate.randposition(new1, fill) = nan;
        rate.rating(new1, fill)=nan;
        rate.RT(new1,fill)=nan;
    end
end

%% SAVE EVERYTHING
% =========================================================================
rate.end(new1, 1) = GetSecs;
save(savewhere, 'rate');  % save everything

end   % main function