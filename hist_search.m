function [ ] = hist_search( ref_img, dest_path )
%SEARCH Search for the best matching image using RGB histogram similarity.

    % Read in the reference image.
    ref = imread(ref_img);
    
    % Get the histograms of the reference image with N = 48 bins.
    N = 48;
    x = 1:N;
    ref_hist = get_histogram(ref, N);
    
    % Display the original image along with its RGB histograms.
    subplot(2, 2, 1);
    imshow(ref);
    subplot(2, 2, 2);
    plot(x, ref_hist(:, 1), 'red s');
    subplot(2, 2, 3);
    plot(x, ref_hist(:, 2), 'green s');
    subplot(2, 2, 4);
    plot(x, ref_hist(:, 3), 'blue s');
    waitforbuttonpress;
    
    % Search for the best RGB match.
    image_files = dir([dest_path '*.jpg']);
    best_diff = -1;
    best_match = 'none';
    for i = 1 : length(image_files)
        % Read test image. Make sure it is RGB.
        img_name = image_files(i).name;
        img = imread([dest_path img_name]);
        [~, ~, num_channels] = size(img);
        if num_channels ~= 3
            continue;
        end
        % Get its RGB histograms and compare to reference image.
        img_hist = get_histogram(img, N);
        diff = hist_diff(img_hist, ref_hist);
        if best_diff == -1 || best_diff > diff
            best_diff = diff;
            best_match = img_name;
        end
    end
    
    % Read the matched image and get its RGB histograms.
    match = imread([dest_path best_match]);
    match_hist = get_histogram(match, N);
        
    disp(best_match);
    
    subplot(4, 2, 1);
    imshow(ref);
    subplot(4, 2, 2);
    plot(x, ref_hist(:, 1), 'red s');
    subplot(4, 2, 3);
    plot(x, ref_hist(:, 2), 'green s');
    subplot(4, 2, 4);
    plot(x, ref_hist(:, 3), 'blue s');
    subplot(4, 2, 5);
    imshow(match);
    subplot(4, 2, 6);
    plot(x, match_hist(:, 1), 'red s');
    subplot(4, 2, 7);
    plot(x, match_hist(:, 2), 'green s');
    subplot(4, 2, 8);
    plot(x, match_hist(:, 3), 'blue s');
    
end


function [ diff ] = hist_diff( hist1, hist2 )
%HIST_DIFF Returns the difference (or 'distance') between the two given RGB
%histograms as a numerical value.

    red_diff = norm(hist1(:, 1) - hist2(:, 1));
    grn_diff = norm(hist1(:, 2) - hist2(:, 2));
    blu_diff = norm(hist1(:, 3) - hist2(:, 3));
    
    diff = red_diff + grn_diff + blu_diff;
    
end

function [ hist ] = get_histogram( rgb_image, n )
%GET_HISTOGRAM Returns a histogram of n bins as a matrix of 3 n by 1
%column vectors.
    
    % Create a histogram for each channel.
    [red_hist, ~] = imhist(rgb_image(:, :, 1), n); % red channel
    [grn_hist, ~] = imhist(rgb_image(:, :, 2), n); % green channel
    [blu_hist, ~] = imhist(rgb_image(:, :, 3), n); % blue channel
    
    % Normalize the histogram values.
    red_hist = red_hist / norm(red_hist);
    grn_hist = grn_hist / norm(grn_hist);
    blu_hist = blu_hist / norm(blu_hist);

    % Create an array (3-column matrix) of the three histograms.
    hist = [ red_hist grn_hist blu_hist ];

end