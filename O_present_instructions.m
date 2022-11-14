function [timings] = O_present_instructions(pr, folder, extension)
%  function O_present_instructions(pr, folder, extension)
%  show instructions with PTB
%  reads *extension files from folder and shows them in a slideshow.
%
% Original: 2017-03 ITK
% Modified: 2017-05-18 Antonius Wiehler <antonius.wiehler@gmail.com>

YES = 1; NO = 0; % Used to define different stages of the trial


%% SETUP PSYCHTOOLBOX IF NOT OPEN YET
% =========================================================================

if ~isempty(pr) & isfield(pr, 'ptb')
    ptb = pr.ptb;
else  % if we dont have strcture yet we will open a new window
    ptb = O_open_screen_v02(0);
end


%% BUILD LIST OF IMAGE FILENAMES
% =========================================================================

files = dir([folder '*' extension]);

if isempty(files)
    error('No instruction files found in: %s.\n', folder);
end % if folder is empty

files = struct2cell(files);  % convert to cell
files = files(1, :);  % save only names


%% READ IMAGE FILES
% =========================================================================

for i_f = 1 : length(files)
    instruction_filenames{i_f} = fullfile(folder, files{i_f});
    images{i_f} = imread(instruction_filenames{i_f});
end

%% SHOW INSTRUCTIONS
% =========================================================================
exit_ptb=NO;

cnt = 0;
reach_end = NO;

while reach_end == NO
    
    cnt = cnt + 1;
    
    imageTexture = Screen('MakeTexture', ptb.PTBwindow, images{cnt});
    Screen('DrawTexture', ptb.PTBwindow, imageTexture, [], [], 0);
    timestamp = Screen('Flip', ptb.PTBwindow);
    change_slide = NO;
    if cnt == 1
         timings = BEC_Timekeeping('InstructionScreen',pr.plugins,timestamp);
    else
         timings = [timings BEC_Timekeeping('InstructionScreen',pr.plugins,timestamp)]; %#ok<AGROW>
    end
    while change_slide == NO
        
        % record key response
        [secs, keyCode, deltaSecs] = KbWait(-1, 2);
        
        if keyCode(ptb.abortKey)
            exit_ptb = YES; break;
        else
            
            if keyCode(ptb.rightKey) %continue
                if cnt == length(instruction_filenames) % if we are at the last slide
                    
                  %  [secs, keyCode, deltaSecs] = KbWait(-1, 2);  %% Shruti: IS THERE A PROBLEM HERE? 
                    
                    if keyCode(ptb.rightKey) %continue
                        exit_ptb = YES; reach_end = YES; change_slide = YES;
                        break;
                    end
                    
                else
                    change_slide = YES; break;
                end
                
            elseif keyCode(ptb.leftKey) == 1 %go back
                change_slide = YES;
                if cnt < 2
                    cnt = cnt - 1;
                else
                    cnt = cnt - 2;
                end
                break;
            end
        end
        if exit_ptb == YES
            break;
        end
    end
    
    if exit_ptb == YES
        break;
    end
end

if exit_ptb == YES
    if ~isfield(pr, 'ptb')
        Priority(0);
        %sca;
    else
        Screen('Flip', ptb.PTBwindow);
        WaitSecs(2);    
    end
end

end  % function