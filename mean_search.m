function [ ] = mean_search( ref_img, dest_path )
%MEAN_SEARCH Search for the best matching image using mean RGB.

    if strcmp(ref_img, 'r')
        ref_rgb = [1 0 0];
    elseif strcmp(ref_img, 'g')
        ref_rgb = [0 1 0];
    elseif strcmp(ref_img, 'b')
        ref_rgb = [0 0 1];
    else
        ref = imread(ref_img);
        ref_rgb = mean(reshape(ref, [], 3));
    end
    ref_rgb = ref_rgb / norm(ref_rgb);
    
    if exist('ref', 'var')
        subplot(2, 1, 1);
        imshow(ref);
    end
    subplot(2, 1, 2);
    bar(1, ref_rgb(1), 'r');
    hold on;
    bar(2, ref_rgb(2), 'g');
    hold on;
    bar(3, ref_rgb(3), 'b');
    waitforbuttonpress;
    
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
        
        img_rgb = mean(reshape(img, [], 3));
        img_rgb = img_rgb / norm(img_rgb);
        diff = norm(img_rgb - ref_rgb);
        
        if best_diff == -1 || diff < best_diff
            best_diff = diff;
            best_match = img_name;
        end
    end
    
    disp(best_match);
    match = imread([dest_path best_match]);
    match_rgb = mean(reshape(img, [], 3));
    match_rgb = match_rgb / norm(match_rgb);
    
    if exist('ref', 'var')
        subplot(2, 2, 1);
        imshow(ref);
    end
    subplot(2, 2, 2);
    bar(1, ref_rgb(1), 'r');
    hold on;
    bar(2, ref_rgb(2), 'g');
    hold on;
    bar(3, ref_rgb(3), 'b');
    
    subplot(2, 2, 3);
    imshow(match);
    subplot(2, 2, 4);
    bar(1, match_rgb(1), 'r');
    hold on;
    bar(2, match_rgb(2), 'g');
    hold on;
    bar(3, match_rgb(3), 'b');
    
end

