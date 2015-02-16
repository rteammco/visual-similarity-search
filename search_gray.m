function [ ] = search_gray( ref_img, dest_path )
%SEARCH_GRAY Search for the best matching image using grayscale histogram
%similarity.

    ref = imread(ref_img);
    ref_gray = rgb2gray(ref);

    [ref_hist, x] = imhist(ref_gray);
    ref_hist = ref_hist / norm(ref_hist);
    
    
    % Display the original image along with its histogram.
    subplot(2, 2, 1);
    imshow(ref);
    subplot(2, 2, 2);
    imshow(ref_gray);
    subplot(2, 2, 3);
    plot(x, ref_hist, 'black s');
    waitforbuttonpress;
    
    % Search for the best match.
    image_files = dir([dest_path '*.jpg']);
    best_diff = -1;
    best_match = 'none';
    for i = 1 : length(image_files)
        img_name = image_files(i).name;
        img = imread([dest_path img_name]);
        [~, ~, num_channels] = size(img);
        if num_channels ~= 3
            continue;
        end
        img_gray = rgb2gray(img);
        [img_hist, ~] = imhist(img_gray);
        diff = norm(ref_hist - img_hist);
        if best_diff == -1 || best_diff > diff
            best_diff = diff;
            best_match = img_name;
        end
    end
    
    % Read the matched image and get its RGB histograms.
    match = imread([dest_path best_match]);
    match_gray = rgb2gray(match);
    [match_y, ~] = imhist(match_gray);
    match_y = match_y / norm(match_y);
        
    disp(best_match);
    
    subplot(2, 2, 1);
    imshow(match);
    subplot(2, 2, 2);
    imshow(match_gray);
    subplot(2, 2, 3);
    imshow(ref);
    subplot(2, 2, 4);
    plot(x, match_y, 'black s');
    
end