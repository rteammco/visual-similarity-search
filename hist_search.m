function [ ] = hist_search( ref_img, dest_path )
%SEARCH Search for the best matching image using RGB histogram similarity.
%   TODO - use get_histograms to load all files and compute histograms
%   first, then search in-memory for the top N similar images.

    % Read in the reference image.
    ref = imread(ref_img);
    
    % Get the histograms of the reference image with N = 48 bins.
    N = 48;
    x = 1:N;
    ref_hist = get_rgb_histogram(ref, N);
    
    % Display the original image along with its RGB histograms.
    subplot(2, 2, 1); imshow(ref);
    subplot(2, 2, 2); plot(x, ref_hist(:, 1), 'red s');
    subplot(2, 2, 3); plot(x, ref_hist(:, 2), 'green s');
    subplot(2, 2, 4); plot(x, ref_hist(:, 3), 'blue s');
    waitforbuttonpress;
    
    % Search for the best RGB match.
    image_files = getAllFiles(dest_path);
    best_diff = -1;
    best_match = 'none';
    for i = 1 : length(image_files)
        % Read test image. Make sure it is RGB.
        img_name = image_files{i};
        if strcmp(img_name, ref_img) || ~strEndsWith(img_name, 'jpg')
            continue;
        end
        disp(img_name);
        img = imread(img_name);
        %img_name = image_files(i).name;
        %img = imread([dest_path img_name]);
        [~, ~, num_channels] = size(img);
        if num_channels ~= 3
            continue;
        end
        % Get its RGB histograms and compare to reference image.
        img_hist = get_rgb_histogram(img, N);
        diff = hist_diff(img_hist, ref_hist);
        if best_diff == -1 || best_diff > diff
            best_diff = diff;
            best_match = img_name;
        end
    end
    
    % Read the matched image and get its RGB histograms.
    match = imread(best_match);
    match_hist = get_rgb_histogram(match, N);
        
    disp(best_match);
    
    subplot(4, 2, 1); imshow(ref);
    subplot(4, 2, 2); plot(x, ref_hist(:, 1), 'red s');
    subplot(4, 2, 3); plot(x, ref_hist(:, 2), 'green s');
    subplot(4, 2, 4); plot(x, ref_hist(:, 3), 'blue s');
    subplot(4, 2, 5); imshow(match);
    subplot(4, 2, 6); plot(x, match_hist(:, 1), 'red s');
    subplot(4, 2, 7); plot(x, match_hist(:, 2), 'green s');
    subplot(4, 2, 8); plot(x, match_hist(:, 3), 'blue s');
    
end


function [ diff ] = hist_diff( hist1, hist2 )
%HIST_DIFF Returns the difference (or 'distance') between the two given RGB
%histograms as a numerical value.

    red_diff = norm(hist1(:, 1) - hist2(:, 1));
    grn_diff = norm(hist1(:, 2) - hist2(:, 2));
    blu_diff = norm(hist1(:, 3) - hist2(:, 3));
    
    diff = red_diff + grn_diff + blu_diff;
    
end