function [] = puzzle_GCL_test_function(img_path, output_folder, patch_size, cols, rows)
    % requires software gurobi (this is required for the PuzzleDemoLP)

    addpath(genpath('PuzzleDemoLP')) % We obtained this code from the authors of Yu et al. work
    addpath(genpath('utils'))  

    % patch_size = 28; % size of puzzle patches
    % cols = 27; % number of puzzle columns
    % rows = 20; % number of puzzle rows 
    number_iter = 5; % number of iterations to possibly correct the mistakes 

    [res_all_sol, err_all, real_goal_all, res_all, rotsNum_first, rotsNum, large_Image, ratio] = solve_type_2_img(img_path, patch_size, cols, rows, number_iter);

    [~, image_name, ~] = fileparts(img_path);
    output_file = fullfile(output_folder, image_name);
    
    output_txt = fullfile(output_folder, 'record.txt');
    imwrite(large_Image, [output_file, '.png']);
    
    fileID = fopen(output_txt,'a');
    fprintf(fileID,'%s\t',image_name);
    fprintf(fileID,'%f\n',ratio);
    fclose(fileID);
end
