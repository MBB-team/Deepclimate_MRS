function [exitflag,timings,AllData] = TASK_InstructionScreens(window,AllData,which_instruction)
% Enter the slides to put on screen. Wait for the space bar or right arrow 
% to be pressed in order to move on to the next slide, or left arrow to return to previous slide.

%Prepare
    exp_settings = AllData.exp_settings;
    if(which_instruction<0)
       %task instructions
        if AllData.task_group == 1
           folder = [exp_settings.stimdir filesep 'nswitch' filesep 'training_group_01' filesep];
        elseif AllData.task_group == 2
           folder = [exp_settings.stimdir filesep 'nswitch' filesep 'training_group_02' filesep];
        end 
    end
    AllData.ptb.PTBwindow = window;
    AllData.ptb.debug = 1;
    KbName('UnifyKeyNames');
  %  AllData.ptb.leftKey     = KbName('LeftArrow');
  %  AllData.ptb.rightKey    = KbName('RightArrow');
  %For MRI: Settings on the response box 
    %USB 002
    %HHSC-2XL-CYL
    %HID NAR BYGRT
    AllData.ptb.leftKey     = KbName('b');
    AllData.ptb.rightKey    = KbName('y');
    AllData.ptb.abortKey    = KbName('Escape');

    [timings] = O_present_instructions(AllData, folder, '.png');  % show the instructions
    exitflag = 0;

end %subfunction
