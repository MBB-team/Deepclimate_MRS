function color = O_load_colors(hostname)

%% STANDARD COLORS
% =========================================================================

% color.black      = [0 0 0]       ./ 255;
% color.white      = [255 255 255] ./ 255;
% color.grey       = [128 128 128] ./ 255;
% color.red        = [255 0 0]     ./ 255;
% color.green      = [0 220 0]     ./ 255;
% color.blue       = [0 0 255]     ./ 255;

color.black      = [0 0 0]       ;
color.white      = [255 255 255] ;
color.grey       = [128 128 128] ;
color.red        = [255 0 0]     ;
color.green      = [0 220 0]    ;
color.blue       = [0 0 255]    ;


%% LUMINANCE MATCHED COLORS
% =========================================================================
% Calibration was done with Monaco Opti xr 2005. After creating a monitor
% profile and loading it with DisplayCal, Colors have been manually adjusted to
% closely match the luminance of [128 128 128] grey.
% Luminance values were obtained with Monaco Opti xr 2005 DTB 94 in free
% measurement mode in DisplayCal. A higher precision is not possible
% with this measurement device.

switch hostname
    
    case 'PRISME-F007'
        color.calibration.user   = 'AW';
        color.calibration.date   = '2017-03-06';
        color.calibration.device = 'DTP94';
        
        color.luminance.unit     = 'cd/m^2';
        color.luminance.grey     = 26.41;
        color.luminance.blue     = 26.45;
        color.luminance.pink     = 26.27;
        color.luminance.orange   = 26.72;
        color.luminance.green    = 26.84;
        color.luminance.red      = 26.37;
        
        color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        color.lum_matched.blue   = [0 118 255]   ./ 255;  % blue
        color.lum_matched.pink   = [241 0 180]   ./ 255;  % pink
        color.lum_matched.orange = [204 105 0]   ./ 255;   % orange
        color.lum_matched.green  = [0 152 0]     ./ 255;  % green
        color.lum_matched.red    = [255 54 0]    ./ 255;  % red
        
        
    case 'PRISME-F008'
        color.calibration.user   = 'AW';
        color.calibration.date   = '2017-03-06';
        color.calibration.device = 'DTP94';
        
        color.luminance.unit     = 'cd/m^2';
        color.luminance.grey     = 26.23;
        color.luminance.blue     = 26.09;
        color.luminance.pink     = 26.29;
        color.luminance.orange   = 26.24;
        color.luminance.green    = 26.41;
        color.luminance.red      = 26.33;
        
        color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        color.lum_matched.blue   = [0 119 255]   ./ 255;  % blue
        color.lum_matched.pink   = [243 0 180]   ./ 255;  % pink
        color.lum_matched.orange = [203 105 0]   ./ 255;   % orange
        color.lum_matched.green  = [0 153 0]     ./ 255;  % green
        color.lum_matched.red    = [255 49 0]    ./ 255;  % red
        
        
    case 'PRISME-F010'
        color.calibration.user   = 'AW';
        color.calibration.date   = '2017-02-16';
        color.calibration.device = 'DTP94';
        
        color.luminance.unit     = 'cd/m^2';
        color.luminance.grey     = 22.89;
        color.luminance.blue     = 22.64;
        color.luminance.pink     = 22.41;
        color.luminance.orange   = 22.83;
        color.luminance.green    = 22.98;
        color.luminance.red      = 22.72;
        
        color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        color.lum_matched.blue   = [0 113 255]   ./ 255;  % blue
        color.lum_matched.pink   = [233 0 174]   ./ 255;  % pink
        color.lum_matched.orange = [200 97 0]    ./ 255;   % orange
        color.lum_matched.green  = [0 148 0]     ./ 255;  % green
        color.lum_matched.red    = [249 0 0]     ./ 255;  % red
        
        
    case 'PRISME-F011'
        color.calibration.user   = 'AW';
        color.calibration.date   = '2017-02-20';
        color.calibration.device = 'DTP94';
        
        color.luminance.unit     = 'cd/m^2';
        color.luminance.grey     = 24.67;
        color.luminance.blue     = 24.73;
        color.luminance.pink     = 24.63;
        color.luminance.orange   = 24.57;
        color.luminance.green    = 24.77;
        color.luminance.red      = 24.79;
        
        color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        color.lum_matched.blue   = [0 113 255]   ./ 255;  % blue
        color.lum_matched.pink   = [239 0 180]   ./ 255;  % pink
        color.lum_matched.orange = [205 100 0]   ./ 255;  % orange
        color.lum_matched.green  = [0 152 0]     ./ 255;  % green
        color.lum_matched.red    = [255 35 0]    ./ 255;  % red
        
        
    case 'PRISME-F012'
        color.calibration.user   = 'AW';
        color.calibration.date   = '2017-03-06';
        color.calibration.device = 'DTP94';
        
        color.luminance.unit     = 'cd/m^2';
        color.luminance.grey     = 24.71;
        color.luminance.blue     = 24.69;
        color.luminance.pink     = 24.71;
        color.luminance.orange   = 24.73;
        color.luminance.green    = 24.75;
        color.luminance.red      = 24.69;
        
        color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        color.lum_matched.blue   = [0 117 255]   ./ 255;  % blue
        color.lum_matched.pink   = [239 0 177]   ./ 255;  % pink
        color.lum_matched.orange = [205 102 0]   ./ 255;   % orange
        color.lum_matched.green  = [0 151 0]     ./ 255;  % green
        color.lum_matched.red    = [255 25 0]    ./ 255;  % red
        
        
    case 'PRISME-F013'
        color.calibration.user   = 'AW';
        color.calibration.date   = '2017-03-09';
        color.calibration.device = 'DTP94';
        
        color.luminance.unit     = 'cd/m^2';
        color.luminance.grey     = 18.77;
        color.luminance.blue     = 18.79;
        color.luminance.pink     = 18.77;
        color.luminance.orange   = 18.80;
        color.luminance.green    = 18.72;
        color.luminance.red      = 18.71;
        
        color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        color.lum_matched.blue   = [0 118 255]   ./ 255;  % blue
        color.lum_matched.pink   = [243 0 177]   ./ 255;  % pink
        color.lum_matched.orange = [203 107 0]   ./ 255;   % orange
        color.lum_matched.green  = [0 151 0]     ./ 255;  % green
        color.lum_matched.red    = [255 46 0]    ./ 255;  % red
        
        
    case 'PRISME-F014'
        color.calibration.user   = 'AW';
        color.calibration.date   = '2017-03-06';
        color.calibration.device = 'DTP94';
        
        color.luminance.unit     = 'cd/m^2';
        color.luminance.grey     = 24.70;
        color.luminance.blue     = 24.62;
        color.luminance.pink     = 24.74;
        color.luminance.orange   = 24.66;
        color.luminance.green    = 24.64;
        color.luminance.red      = 24.75;
        
        color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        color.lum_matched.blue   = [0 117 255]   ./ 255;  % blue
        color.lum_matched.pink   = [239 0 180]   ./ 255;  % pink
        color.lum_matched.orange = [205 102 0]   ./ 255;   % orange
        color.lum_matched.green  = [0 152 0]     ./ 255;  % green
        color.lum_matched.red    = [255 45 0]    ./ 255;  % red
        
        
        
    case 'DELLFBA7'  % CENIR PROJECTOR
        color.calibration.user   = 'AW';
        color.calibration.date   = '2017-05-19';
        color.calibration.device = 'DTP94';
        
        color.luminance.unit     = 'cd/m^2';
        color.luminance.grey     = 100.57;
        color.luminance.blue     = 100.63;
        color.luminance.pink     = 99.65;
        color.luminance.orange   = 100.05;
        color.luminance.green    = 99.74;
        color.luminance.red      = 99.82;
        
%         color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
%         color.lum_matched.blue   = [0 121 255]   ./ 255;  % blue
%         color.lum_matched.pink   = [255 32 255]  ./ 255;  % pink
%         color.lum_matched.orange = [205 103 0]   ./ 255;   % orange
%         color.lum_matched.green  = [0 138 0]     ./ 255;  % green
%         color.lum_matched.red    = [255 74 47]   ./ 255;  % red
        
        color.lum_matched.grey   = [128 128 128];  % grey
        color.lum_matched.blue   = [0 121 255]   ;  % blue
        color.lum_matched.pink   = [255 32 255] ;  % pink
        color.lum_matched.orange = [205 103 0]  ;   % orange
        color.lum_matched.green  = [0 138 0]    ;  % green
        color.lum_matched.red    = [255 74 47]  ;  % red     
        
        
    case 'gursky'  % SONY screen at CENIR
        color.calibration.user   = 'AW';
        color.calibration.date   = '2017-06-09';
        color.calibration.device = 'DTP94';
        
        color.luminance.unit     = 'cd/m^2';
        color.luminance.grey     = 34.90;
        color.luminance.blue     = 35.11;
        color.luminance.pink     = 34.90;
        color.luminance.orange   = 35.35;
        color.luminance.green    = 34.86;
        color.luminance.red      = 35.08;
        
%         color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
%         color.lum_matched.blue   = [0 121 255]   ./ 255;  % blue
%         color.lum_matched.pink   = [220 0 160]  ./ 255;  % pink
%         color.lum_matched.orange = [205 90 0]   ./ 255;   % orange
%         color.lum_matched.green  = [0 152 0]     ./ 255;  % green
%         color.lum_matched.red    = [233 0 0]   ./ 255;  % red

        color.lum_matched.grey   = [128 128 128] ;  % grey
        color.lum_matched.blue   = [0 121 255]   ;  % blue
        color.lum_matched.pink   = [220 0 160]  ;  % pink
        color.lum_matched.orange = [205 90 0]   ;   % orange
        color.lum_matched.green  = [0 152 0]   ;  % green
        color.lum_matched.red    = [233 0 0]   ;  % red
        
        
        % behav box at CENIR
    case 'upmc-683b7ab6a7'  % !!! NOT CALIBRATED, ONLY FOR DEBUG
        color.calibration.user   = [];
        color.calibration.date   = [];
        color.calibration.device = [];
        
        color.luminance.unit     = [];
        color.luminance.grey     = [];
        color.luminance.blue     = [];
        color.luminance.pink     = [];
        color.luminance.orange   = [];
        color.luminance.green    = [];
        color.luminance.red      = [];
        
        color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        color.lum_matched.blue   = [0 113 255]   ./ 255;  % blue
        color.lum_matched.pink   = [233 0 174]   ./ 255;  % pink
        color.lum_matched.orange = [200 97 0]    ./ 255;   % orange
        color.lum_matched.green  = [0 148 0]     ./ 255;  % green
        color.lum_matched.red    = [249 0 0]     ./ 255;  % red
        
        
    case 'bansky'  % !!! NOT CALIBRATED, ONLY FOR DEBUG
        color.calibration.user   = [];
        color.calibration.date   = [];
        color.calibration.device = [];
        
        color.luminance.unit     = [];
        color.luminance.grey     = [];
        color.luminance.blue     = [];
        color.luminance.pink     = [];
        color.luminance.orange   = [];
        color.luminance.green    = [];
        color.luminance.red      = [];
        
        color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        color.lum_matched.blue   = [0 113 255]   ./ 255;  % blue
        color.lum_matched.pink   = [233 0 174]   ./ 255;  % pink
        color.lum_matched.orange = [200 97 0]    ./ 255;   % orange
        color.lum_matched.green  = [0 148 0]     ./ 255;  % green
        color.lum_matched.red    = [249 0 0]     ./ 255;  % red
        
        
    case 'MBB03'  % !!! NOT CALIBRATED, ONLY FOR DEBUG
        color.calibration.user   = [];
        color.calibration.date   = [];
        color.calibration.device = [];
        
        color.luminance.unit     = [];
        color.luminance.grey     = [];
        color.luminance.blue     = [];
        color.luminance.pink     = [];
        color.luminance.orange   = [];
        color.luminance.green    = [];
        color.luminance.red      = [];
        
        color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        color.lum_matched.blue   = [0 113 255]   ./ 255;  % blue
        color.lum_matched.pink   = [233 0 174]   ./ 255;  % pink
        color.lum_matched.orange = [200 97 0]    ./ 255;   % orange
        color.lum_matched.green  = [0 148 0]     ./ 255;  % green
        color.lum_matched.red    = [249 0 0]     ./ 255;  % red
        
        
    otherwise
        color.calibration.user   = [];
        color.calibration.date   = [];
        color.calibration.device = [];
        
        color.luminance.unit     = [];
        color.luminance.grey     = [];
        color.luminance.blue     = [];
        color.luminance.pink     = [];
        color.luminance.orange   = [];
        color.luminance.green    = [];
        color.luminance.red      = [];
        
        % !!! NOT CALIBRATED, ONLY FOR DEBUG
        %color.lum_matched.grey   = [128 128 128] ./ 255;  % grey
        %color.lum_matched.blue   = [0 113 255]   ./ 255;  % blue
        %color.lum_matched.pink   = [239 0 180]   ./ 255;  % pink
       %color.lum_matched.orange = [205 100 0]   ./ 255;  % orange
        %color.lum_matched.green  = [0 152 0]     ./ 255;  % green
        %color.lum_matched.red    = [255 35 0]    ./ 255;  % red
        
        color.lum_matched.grey   = [128 128 128] ;  % grey
        color.lum_matched.blue   = [0 113 255]  ;  % blue
        color.lum_matched.pink   = [239 0 180]   ;  % pink
        color.lum_matched.orange = [205 100 0]  ;  % orange
        color.lum_matched.green  = [0 152 0]    ;  % green
        color.lum_matched.red    = [255 35 0]    ;  % red
        
        
end  % switch hostname


color.text       = color.white;
color.highlight  = color.red;
%color.background = color.grey;
%Exceptionally for Deepclimate, we show the background in black.
color.background = color.black;

end  % end function
