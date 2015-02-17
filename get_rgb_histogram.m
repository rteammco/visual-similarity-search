function [ hist ] = get_rgb_histogram( rgb_image, N )
%GET_RGB_HISTOGRAM Returns a normalized histogram of N bins as a matrix of
%   N 3-row vectors.
    
    % Create a histogram for each channel.
    [red_hist, ~] = imhist(rgb_image(:, :, 1), N); % red channel
    [grn_hist, ~] = imhist(rgb_image(:, :, 2), N); % green channel
    [blu_hist, ~] = imhist(rgb_image(:, :, 3), N); % blue channel
    
    % Normalize the histogram values.
    red_hist = red_hist / norm(red_hist);
    grn_hist = grn_hist / norm(grn_hist);
    blu_hist = blu_hist / norm(blu_hist);

    % Create an array (3-column matrix) of the three histograms.
    hist = [ red_hist grn_hist blu_hist ];

end

