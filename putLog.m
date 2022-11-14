function [log] = putLog(log, ptb_time, event_info)
    % function [log] = putLog(log, ptb_time, event_info)
    % Function to log all events.
    % log: cell array of logs.
    % ptb_time: psychtoolbox timing, usually a previous GetSecs, KbCheck,
    % Flip, etc.
    % event_info: (Text-) info about current event.
    %
    %   Author: Antonius Wiehler <antonius.wiehler@gmail.com>
    %   Original: 2017-02-13
    
    if isfield(log, 'event_counter')
        log.event_counter = log.event_counter + 1;  % increase counter
    else
        log.event_counter = 1;  % init to one if not existing
    end
    
    log.events(log.event_counter, 1) = {log.event_counter};  % save counter
    log.events(log.event_counter, 2) = {ptb_time};
    log.events(log.event_counter, 3) = {event_info};
end