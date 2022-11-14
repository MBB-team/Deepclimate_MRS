function [ptb] = O_open_screen_v02(debug,window)
% function [ptb] = O_open_screen_v02(debug)
%   This opens a psychtoolbox Screen with default settings.
%   based on O_open_screen.
%   return structure 'ptb' with all psychtoolbox settings.
%
%   Author: Antonius Wiehler <antonius.wiehler@gmail.com>
%   Original: 2017-01-24


%% SET CONFIGURATION PARAMETERS
% =========================================================================
ptb.fontsize.standard = 30;

%Changed for MRS Screen
ptb.fontsize.nswitch  = 100;

% ptb.fontsize.nswitch  = 70;
ptb.fontsize.nback    = 70;
ptb.fontsize.choice   = 40;
ptb.fontsize.pupil    = 40;
ptb.fontname.standard = 'Arial';
ptb.fontname.nswitch  = 'Times New Roman';
ptb.fontname.nback    = 'Times New Roman';
ptb.fontname.choice   = 'Arial';
ptb.fontname.pupil    = 'Courier New';

%clear Screen  % clear Screen to reset previous config settings

%% LOAD TEXTS WITH FRENCH ACCENTS
% =========================================================================
load accents/accent_texts.mat
ptb.accent = accent;

%% SETUP KEYBAORD
% =========================================================================
KbName('UnifyKeyNames');
%ptb.leftKey     = KbName('LeftArrow'); 
%ptb.rightKey    = KbName('RightArrow');

%For MRI: Settings on the response box 
%USB 002
%HHSC-2XL-CYL
%HID NAR BYGRT

ptb.leftKey     = KbName('b');   %BLUE IS LEFT BUTTON
ptb.rightKey    = KbName('y');   %YELLOW IS RIGHT BUTTON
ptb.TR          = KbName('t');


ptb.topKey      = KbName('UpArrow');
ptb.bottomKey   = KbName('DownArrow');
ptb.spaceKey    = KbName('space');
ptb.returnKey   = KbName('Return');
ptb.returnKey   = ptb.returnKey(1);
ptb.abortKey    = KbName('Escape');
%ptb.yesKey      = KbName('y');
%ptb.noKey       = KbName('n');


%% GET HOSTNAME
% =========================================================================
[~, ptb.hostname] = system('hostname'); % get the name of the PC
ptb.hostname   = deblank(ptb.hostname);


%% SETUP SCREEN
% =========================================================================

if debug
    PsychDebugWindowConfiguration;  % activate for debug
end

%if strcmp(ptb.hostname, 'MBB03') || strcmp(ptb.hostname, 'bansky') % Irma desktop adn Antonius laptop
% PsychDefaultSetup(2);
% Screen('Preference', 'SkipSyncTests', 1);  % to this only in emergency cases, will affect timing
% Screen('Preference', 'VisualDebugLevel', 3); %Visual debug level
% Screen('Preference', 'SuppressAllWarnings', 1);
%ptb.screens          = Screen('Screens');
%ptb.screenNumber     = max(ptb.screens);


%% LOAD COLORS
% =========================================================================
ptb.color = O_load_colors(ptb.hostname);

%% OPEN WINDOW
% =========================================================================

%[ptb.PTBwindow, ptb.PTBwindowRect]     = PsychImaging('OpenWindow', ptb.screenNumber, ptb.color.background);
ptb.PTBwindow = window;
ptb.PTBwindowRect = Screen('rect',ptb.PTBwindow);
Screen('FillRect',ptb.PTBwindow,ptb.color.background, ptb.PTBwindowRect);
[ptb.xCenter, ptb.yCenter]             = RectCenter(ptb.PTBwindowRect);

[ptb.screenXpixels, ptb.screenYpixels] = Screen('WindowSize', ptb.PTBwindow);
ptb.nominalFrameRate                   = Screen('NominalFrameRate', ptb.PTBwindow);
ptb.FlipInterval                       = Screen('GetFlipInterval', ptb.PTBwindow);
Screen('BlendFunction', ptb.PTBwindow, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');   % Anti-aliasing + enable transparency

Screen('TextSize', ptb.PTBwindow, ptb.fontsize.standard);  % set standard text size
Screen('TextFont', ptb.PTBwindow, ptb.fontname.standard);  % set standard text font
Screen('TextColor', ptb.PTBwindow, ptb.color.text);  % set standard text color
Screen('Preference', 'TextAntiAliasing', 8);

if ~debug
    HideCursor();  % hide cursor only when not in debug
end

%% OPTION BOXES
% =========================================================================

% define boxes for text in two alternative choice tasks
% [left top right bottom]
% box_length = ptb.screenYpixels ./ 4;  % define box size in relation to screen size
% 
% left_left = (ptb.screenXpixels ./ 3) - ( box_length ./ 2);
% left_top = (ptb.screenYpixels ./ 2) - ( box_length ./ 2);
% left_right = (ptb.screenXpixels ./ 3) + ( box_length ./ 2);
% left_bottom = (ptb.screenYpixels ./ 2) + ( box_length ./ 2);
% 
% right_left = ((ptb.screenXpixels .* 2) ./ 3) - ( box_length ./ 2);
% right_top = (ptb.screenYpixels ./ 2) - ( box_length ./ 2);
% right_right = ((ptb.screenXpixels .* 2) ./ 3) + ( box_length ./ 2);
% right_bottom = (ptb.screenYpixels ./ 2) + ( box_length ./ 2);
% 
% ptb.textbox.left = [left_left left_top left_right left_bottom];
% ptb.textbox.right = [right_left right_top right_right right_bottom];



% define box for task reminder
box_length = ptb.screenYpixels ./ 5;  % define box size in relation to screen size

up_left = (ptb.screenXpixels ./ 2) - ( box_length ./ 2);
up_top = (ptb.screenYpixels ./ 3) - ( box_length ./ 2);
up_right = (ptb.screenXpixels ./ 2) + ( box_length ./ 2);
up_bottom = (ptb.screenYpixels ./ 3) + ( box_length ./ 2);

ptb.textbox.up = [up_left up_top up_right up_bottom];


end
