function [ histograms, image_names ] = get_histograms( root_dir, N )
%GET_HISTOGRAMS Returns tuples of image names and their respective RGB
%histograms in the following form:
%   [ ]

    histograms = zeros(0, N, 3);
    image_names = {};
    
    image_files = getAllFiles(root_dir);
    img_num = 1;
    for i = 1 : length(image_files)
        % If file name matches an image extension, make sure it is RGB.
        img_name = image_files{i};
        if ~strEndsWith(img_name, 'jpg') && ~strEndsWith(img_name, 'png')
            continue;
        end
        img = imread(img_name);
        [~, ~, num_channels] = size(img);
        if num_channels ~= 3
            continue;
        end
        
        % Get the image's RGB histogram, and store it in the tuple.
        hist = get_rgb_histogram(img, N); % N by 3 matrix
        histograms(img_num, :, :) = hist;
        image_names{img_num} = img_name;
        
        img_num = img_num + 1;
    end

end

