function [ retval ] = strEndsWith( str, suffix )
%STRENDSWITH Summary of this function goes here
%   Detailed explanation goes here

    retval = 0;
    if length(str) >= length(suffix) && length(suffix) >= 1
        start = length(str) - length(suffix) + 1;
        eos = str(start : length(str));
        if strcmp(eos, suffix)
            retval = 1;
        end
    end

end

